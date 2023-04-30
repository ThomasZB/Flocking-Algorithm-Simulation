# Flocking-Algorithm-Simulation
> 我这里算法是根据论文上面的公式敲出来的，相关原理并不是很了解，目的是完成概率机器人作业。虽然作者本事是做机器人的，但并不涉及到集群上面的项目，**如代码有疏漏欢迎指出~**

项目参考[github python代码](https://github.com/amirhosseinh77/Flocking-Multi-Agent)， [Flocking for multi-agent dynamic systems: algorithms and theory](https://ieeexplore.ieee.org/document/1605401)

项目仿真的是论文第三部分：FLOCKING WITH OBSTACLE AVOIDANCE，也就是包含了避障的代码，核心公式如下
$$u_i=u_i^\alpha+u_i^\beta+u_i^\gamma$$
这里的 $u_i$ 可以理解为合力， $u_i^\alpha$ 可以理解为 $\alpha$ 智能体之间相互作用力， $u_i^\beta$ 可以理解为 $\alpha$ 智能体（机器人）和 $\beta$ 智能体（障碍物）之间的作用力， $u_i^\gamma$ 可以理解为终点对智能体的吸引力。

具体细节可以尝试删除某个分量，看看仿真表现，代码中的一些超参数都是凭感觉设置的，并未调整到最佳，若有兴趣可以尝试调整参数看看仿真表现。

![image](https://raw.githubusercontent.com/ThomasZB/Flocking-Algorithm-Simulation/main/images/QQ2023430-11955-HD.gif)
