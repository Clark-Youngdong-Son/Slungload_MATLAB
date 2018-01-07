function obj = drawRotor_syd(position,attitude,color_arm)

x = position(1);
y = position(2);
z = position(3);
phi = attitude(1);
theta = attitude(2);
psi = attitude(3);
r = 0.5; %arm length
r_rotor = 0.25;
%% Arm
%arm position
arm1 = [+r*sqrt(2)/2,+r*sqrt(2)/2,0].';
arm2 = [+r*sqrt(2)/2,-r*sqrt(2)/2,0].';
arm3 = [-r*sqrt(2)/2,+r*sqrt(2)/2,0].';
arm4 = [-r*sqrt(2)/2,-r*sqrt(2)/2,0].';
%rotation
arm1_delta = Rotate_syd(phi,theta,psi,arm1);
arm2_delta = Rotate_syd(phi,theta,psi,arm2);
arm3_delta = Rotate_syd(phi,theta,psi,arm3);
arm4_delta = Rotate_syd(phi,theta,psi,arm4);
arm1_delta(3) = -arm1_delta(3);
arm2_delta(3) = -arm2_delta(3);
arm3_delta(3) = -arm3_delta(3);
arm4_delta(3) = -arm4_delta(3);
arm1 = [x y -z].'+arm1_delta;
arm2 = [x y -z].'+arm2_delta;
arm3 = [x y -z].'+arm3_delta;
arm4 = [x y -z].'+arm4_delta;
%% drawing
h = zeros(9,1);
h(1) = plot3(x,y,-z,'ko','MarkerSize',5,'MarkerFaceColor','k'); hold on;
h(2) = drawLine([x y -z].',arm1,[1 0.4 0.4]);
h(3) = drawLine([x y -z].',arm2,[1 0.4 0.4]);
h(4) = drawLine([x y -z].',arm3,color_arm);
h(5) = drawLine([x y -z].',arm4,color_arm);
temp = Rotate_syd(phi,theta,psi,eye(3));
temp(3,:) = -temp(3,:);
h(6) = drawCircle3D(arm1,temp,r_rotor);
h(7) = drawCircle3D(arm2,temp,r_rotor);
h(8) = drawCircle3D(arm3,temp,r_rotor);
h(9) = drawCircle3D(arm4,temp,r_rotor);
obj = h;
end

function object = drawLine(X, Y, color, width)

if nargin == 2
	line([X(1), Y(1)], [X(2), Y(2)], [X(3), Y(3)], 'LineWidth', 4, 'Color', [0.5 .5 1]);
elseif nargin == 3
	object = line([X(1), Y(1)], [X(2), Y(2)], [X(3), Y(3)], 'LineWidth', 4, 'Color', color);
else
	object = line([X(1), Y(1)], [X(2), Y(2)], [X(3), Y(3)], 'LineWidth', width, 'Color', color);
end

end

function object = drawCircle3D(center, Rotation_matrix, radius)

theta = 0:0.01:2*pi;
points = bsxfun(@plus, center, radius*(Rotation_matrix(:,1)*cos(theta) + Rotation_matrix(:,2)*sin(theta)));
object = plot3(points(1,:),points(2,:),points(3,:), 'k-');

end