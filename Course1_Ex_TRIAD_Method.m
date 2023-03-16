clc;clear;close all;

%% Setup the true attitude states
% v1 = s   v2 = m
% s_N = [1;0;0];
% m_N = [0;0;1];
s_N = [-0.1517;-0.9669;0.205];
m_N = [-0.8393;0.4494;-0.3044];

t1_N = s_N;
t2_N = cross(s_N,m_N)/norm(cross(s_N,m_N));
t3_N = cross(t1_N,t2_N);

NT = [t1_N t2_N t3_N];

%% Setup the measured attitude states
% s_B = [0.819;-0.5282;0.2242];
% m_B = [-0.3138;-0.1584;0.9362];
s_B = [0.8273;0.5541;-0.092];
m_B = [-0.8285;0.5522;-0.0955];

s_B = s_B/norm(s_B);
m_B = m_B/norm(m_B);

t1_B = s_B;
t2_B = cross(s_B,m_B)/norm(cross(s_B,m_B));
t3_B = cross(t1_B,t2_B);

BT = [t1_B t2_B t3_B];

%% Check accuracy of estimation
BN = BT*NT';
AC = BN*BN';
