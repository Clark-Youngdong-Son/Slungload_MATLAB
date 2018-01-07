function obj = drawSuspensionCableLoad(position,attitude,swingAngle,length,suspension,loadSize,suspensionColor,cableColor,loadColor)

x = position(1);
y = position(2);
z = position(3);
phi = attitude(1);
theta = attitude(2);
psi = attitude(3);
phi_L = swingAngle(1);
theta_L = swingAngle(2);

h = zeros(4,1);
%% Suspension
suspension_delta = Rotate_syd(phi,theta,psi,suspension);
suspension_delta(3) = - suspension_delta(3);
suspension_I = [x y -z].' + suspension_delta;
h(1) = drawLine([x y -z].',suspension_I,suspensionColor);
h(2) = plot3(suspension_I(1),suspension_I(2),suspension_I(3),'o','MarkerSize',3,'MarkerFaceColor',suspensionColor);

%% Cable
suspension_swing_delta = Rotate_Y(theta_L)*Rotate_X(phi_L)*[0 0 length].';
suspension_swing_delta(3) = -suspension_swing_delta(3);
load_I = suspension_I + suspension_swing_delta;
h(3) = drawLine(suspension_I,load_I,cableColor);

%% Load
[X,Y,Z] = sphere(20);
X_load = X*loadSize + load_I(1);
Y_load = Y*loadSize + load_I(2);
Z_load = Z*loadSize + load_I(3);
h(4) = surface(X_load,Y_load,Z_load,'FaceColor',loadColor,'EdgeColor','none');

obj = h;
%% Library

    function object = drawLine(X, Y, color, width)
        
        if nargin == 2
            line([X(1), Y(1)], [X(2), Y(2)], [X(3), Y(3)], 'LineWidth', 2, 'Color', [0.5 .5 1]);
        elseif nargin == 3
            object = line([X(1), Y(1)], [X(2), Y(2)], [X(3), Y(3)], 'LineWidth', 2, 'Color', color);
        else
            object = line([X(1), Y(1)], [X(2), Y(2)], [X(3), Y(3)], 'LineWidth', width, 'Color', color);
        end
        
    end

    function rotation = Rotate_X(angle)
        rotation = [1 0 0;
            0 cos(angle) -sin(angle);
            0 sin(angle) cos(angle)];
    end

    function rotation = Rotate_Y(angle)
        rotation = [cos(angle) 0 sin(angle);
            0 1 0;
            -sin(angle) 0  cos(angle)];
    end
end