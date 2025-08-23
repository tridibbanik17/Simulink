function [zSOC,xf,P1 ] = EKF_PIL(Current,Voltage,C1,C2,C3,R0,R1,R2,R3,x,P)
    dt=1;
    Cn= 5.0051 * 3600;
    eta=1/Cn;
    %Battery Parameters
    Uocv_Poly = [1.85860168453613	-7.25792086526517	23.1888485334774	-44.8281291246205	44.3402094944622	-22.2025482897519	6.29893272877670	2.77742988616164];
        
    %% EXTENDED KALMAN FILTER
    Q=diag([9.8933e-6 5.8643e-6 1.1502e-7 5.1534e-7]); % covariance of process
    R=0.1712;        % covariance of measurement  0.1
    
    %%
    curr=Current;
    z = Voltage;     % measurments
    
      f=@(x)[( 1-dt/(R1*C1) )*x(1)+dt*curr/C1;...
           ( 1-dt/(R2*C2) )*x(2)+dt*curr/C2;...
           ( 1-dt/(R3*C3) )*x(3)+dt*curr/C3;...
           x(4)-dt*eta*curr];  % Nonlinear equations - Kalman Filter
    
      h=@(x) polyval(Uocv_Poly,x(4))  -x(1)-x(2)-x(3)-curr*R0; % Measurement equations - Kalman Filter
    
    [xf,P1] = ekf1(f,x,P,h,z,Q,R);
    xV_e = xf ;                           % save states
    zSOC=xV_e(4,1);                             %SOC
    
    %zV_e  = h_fun(xf);                          % save voltage estimated
    function [x,P,V_error]=ekf1(f,x,P,h,z,Q,R)
    % EKF   Extended Kalman Filter for nonlinear dynamic systems
    % [x, P] = ekf(f,x,P,h,z,Q,R) returns state estimate, x and state covariance, P 
    % for nonlinear dynamic system:
    %           x_k+1 = f(x_k) + w_k
    %           z_k   = h(x_k) + v_k
    % where w ~ N(0,Q) meaning w is gaussian noise with covariance Q
    %       v ~ N(0,R) meaning v is gaussian noise with covariance R
    % Inputs:   f: function handle for f(x)
    %           x: "a priori" state estimate
    %           P: "a priori" estimated state covariance
    %           h: fanction handle for h(x)
    %           z: current measurement
    %           Q: process noise covariance 
    %           R: measurement noise covariance
    % Output:   x: "a posteriori" state estimate
    %           P: "a posteriori" state covariance
    %

        [x2, A] = jaccsd1(f, x);     % Linearize state transition
        P = A * P * A' + Q;          % Predict covariance
    
        [z1, H] = jaccsd2(h, x2);    % Linearize measurement
        P12 = P * H';                % Cross covariance
    
        % Innovation covariance
        S = H * P12 + R;
        S = (S + S') / 2;            % Force symmetry
        S = S + 1e-6 * eye(size(S)); % Regularize to ensure positive definiteness
    
        % Cholesky decomposition (safe for code generation)
        U = chol(S, 'lower');        % Use lower-triangular form for numerical stability
    
        % Kalman gain and update
        K = P12 / U;
        x = x2 + K * (U' \ (z - z1));
        V_error = z - z1;
    
        % Covariance update
        P = P - K * K';
        P = (P + P') / 2;            % Ensure symmetry
        P = P + 1e-6 * eye(size(P)); % Regularize again


        function [z,A]=jaccsd1(f,x3)
            % JACCSD Jacobian through complex step differentiation
                        % [z J] = jaccsd(f,x)
                        % z = f(x)
                        % J = f'(x)
            %
            z=f(x3);
            n=numel(x3);
            m=numel(z);
            A=zeros(m,n);
            h1=n*eps;
            x1=ones(n,1).*complex(n,1);
            for k=1:n
                x1=x3;
                x1(k)=(x1(k)+h1*1i);
                A(:,k)=imag(f(x1))/h1;
            end
        end
    
    
        function [z,A]=jaccsd2(h, x3)
            % JACCSD Jacobian through complex step differentiation
                        % [z J] = jaccsd(f,x)
                        % z = f(x)
                        % J = f'(x)
            z=h(x3);
            n=numel(x3);
            m=numel(z);
            A=zeros(m,n);
            h1=n*eps;
            x1=ones(n,1).*complex(n,1);
            for k=1:n
                x1=x3;
                x1(k)=(x1(k)+h1*1i);
                A(:,k)=imag(h(x1))/h1;
            end
        end
    
    
    end
end

