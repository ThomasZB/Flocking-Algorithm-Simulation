clear;
clc;
% 参数
N = 15;     % 智能体个数
dt = 0.1;   % 步进
T = 200;    % 仿真时间
L = 200;    % 区域大小
R = 10;     % 智能体相互作用范围
D = 8;      % 智能体之间保持的距离（过大排斥，过小吸引）
D_O = 8;    % 和障碍物之间的距离
vmax = 2;   % 最大速度
Destination = [150, 150];   % 目的地
c1_alpha = 2;
c2_alpha = 3;
c1_beta = 5;
c2_beta = 2;
c1_gamma = 6;
c2_gamma = 4;

% 初始化
x = L/10*rand(N,2)+10; 
v = vmax*randn(N,2); 
t = 0;

% 初始化障碍物
Obstacle_Spheres = [50,50,10; 80,80,10]; % 圆形障碍物，格式为x,y,r
Obstacle_wall = [1,0,10;0,1,10]; % 无限墙体障碍物，Ax+By+C=0
% Obstacle_wall = [];
theta = linspace(0,2*pi);
circles(1,:) = Obstacle_Spheres(1,3)*cos(theta) + Obstacle_Spheres(1,1);
circles(2,:) = Obstacle_Spheres(1,3)*sin(theta) + Obstacle_Spheres(1,2);
circles(3,:) = Obstacle_Spheres(2,3)*cos(theta) + Obstacle_Spheres(2,1);
circles(4,:) = Obstacle_Spheres(2,3)*sin(theta) + Obstacle_Spheres(2,2);
lines(1,:)=[-10,-10];
lines(2,:)=[-10,200];
lines(3,:)=[-10,-10];
lines(4,:)=[200,-10];

while t < T
    % Plot positions
    hold off;
    plot(x(:,1),x(:,2),'o');
    hold on;
    plot(circles(1,:), circles(2,:));
    plot(circles(3,:), circles(4,:));
    plot(Destination(1), Destination(2), 'x');
    plot(lines(1,:), lines(2,:));
    plot(lines(4,:), lines(3,:));
    axis([-20 L -20 L]);
    drawnow;
    
    
    % 计算智能体间合力，包括障碍物和智能体
    u_alpha = zeros(N,2);
    u_beta = zeros(N,2);
    for i = 1:N
        % 找到alpha智能体邻居
        d = sqrt(sum((x(i,:)-x).^2,2));     % 和alpha智能体的距离
        N_i_alpha = find(d < R & d > 0);    % 邻居的索引
        % 计算u_alpha
        g1 = zeros(1,2); 
        g2 = zeros(1,2);
        for j = N_i_alpha'
            g1 = g1 + func_phi_alpha(func_sigma_norm(x(j,:)-x(i,:)),R,D) * func_nij(x(j,:)-x(i,:)); % repulsive term
            g2 = g2 + func_aij(x(j,:), x(i,:), R)*(v(j,:)-v(i,:)); % alignment term
        end
        u_alpha(i,:) = c1_alpha*g1 + c2_alpha*g2;

        % 计算和所有圆形beta智能体的距离
        Obstacle_dis_vector = zeros(height(Obstacle_Spheres)+height(Obstacle_wall),2);
        for j = 1:height(Obstacle_Spheres)
            distance_o = Obstacle_Spheres(j,1:2) - x(i,:); % 圆心和智能体距离
            proportion = 1 - Obstacle_Spheres(j,3)/norm(distance_o);% 计算比例
            Obstacle_dis_vector(j,:) = proportion*distance_o;% 得到距离向量
        end
        % 计算和所有墙体beta智能体的距离
        for j = 1:height(Obstacle_wall)
            % 垂直于直线的单位向量
            distance_o = Obstacle_wall(j,1:2) / norm(Obstacle_wall(j,1:2));
            % 点和直线的距离
            proportion = -(Obstacle_wall(j,1)*x(i,1)+Obstacle_wall(j,2)*x(i,2)+Obstacle_wall(j,3))/sqrt(Obstacle_wall(j,1)^2+Obstacle_wall(j,2)^2);
            Obstacle_dis_vector(j+height(Obstacle_Spheres),:) = proportion*distance_o;% 得到距离向量
        end
        % 计算u_beta
        g1 = zeros(1,2); 
        g2 = zeros(1,2);
        for j = 1:height(Obstacle_dis_vector)
            g1 = g1 + func_phi_beta(func_sigma_norm(Obstacle_dis_vector(j,:)),D_O) * func_nij(Obstacle_dis_vector(j,:));
            g2 = g2 + func_bij(Obstacle_dis_vector(j,:), D_O)*(-v(i,:));
        end
        u_beta(i,:) = c1_beta*g1 + c2_beta*g2;
        
        
    end
    % 终点的吸引力
    u_gamma = -c1_gamma*func_sigma_1(x-Destination) - c2_gamma*func_sigma_1(v-[0,0]);

    % 最终合力
    u = u_gamma + u_alpha + u_beta;

    % 更新
    v = v + u*dt;
    x= x + dt*v; 
    t = t + dt

    %pause(0.01);
end

