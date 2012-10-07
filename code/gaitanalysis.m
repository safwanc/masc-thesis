clear all
clf
global m; 
delete('q.csv')
delete('ddq.csv')
delete('dq.csv')
delete('tau.csv')

% config = input('Please enter the configuration number: ');
% if isempty(config)
%     config = 0; 
% end

G = 9.81;
[uLINK, RCONTACT, LCONTACT, TORSO] =  ASLSetupRobot(G);
n = length(uLINK) - 1; 

for i=1:length(uLINK)
    eval([uLINK(i).name,'=',num2str(i),';']);
end

load frames
global start stop contact
for m = start:stop
config = m
LoadGaitData; 
%SetConfiguration; 

uLINK = ASLForwardAllKinematics(1, uLINK, G); 
[f,t, uLINK, FCR, FCL] = ASLInverseDynamics(1, uLINK, LCONTACT, RCONTACT, 0, 0);

jq = zeros(n, 1); 
jdq = zeros(n, 1); 
jddq = zeros(n, 1); 
jtau = zeros(n, 1); 

for i=1:n
    jq(i) = uLINK(i+1).q; 
    jdq(i) = uLINK(i+1).dq; 
    jddq(i) = uLINK(i+1).ddq; 
    jtau(i) = uLINK(i+1).u;
end
clf
ASLShowHome(uLINK);
pause(0.8)
dlmwrite('tau.csv', [config jtau'], '-append'); 
dlmwrite('q.csv', [config jq'], '-append'); 
dlmwrite('dq.csv', [config jdq'], '-append'); 
dlmwrite('ddq.csv', [config jddq'], '-append');
pause(0.8)
end
