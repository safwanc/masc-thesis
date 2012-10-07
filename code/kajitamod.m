if uLINK(RCONTACT).p(3) < 0.0
	Kr = K;	 % Spring Constant
	Br = B;  % Damper Constant
	u = 0.4; % Coefficient of Static Friction
	
	% Velocity of the Contact Point in World Frame:
	vr = uLINK(RCONTACT).vo + cross(uLINK(RCONTACT).w, uLINK(RCONTACT).p); 
	
	% Normal Force Exerted by Spring-Damper Contact Model:
	N = -Kr*uLINK(RCONTACT).p(3)-Br*vr(3);
	
	% Inject Normal Force Into RNE Backwards Pass Initialization:
	FCR = [0 0 N]';
else
	FCR = [0 0 0]'; 
end
