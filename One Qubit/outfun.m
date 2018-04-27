function stop = outfun(x,optimValues,state)
global self;
stop = false;
switch state
    case 'init'
    case 'iter'
         % Concatenate current point and objective function
         % value with history. x must be a row vector.
         self.infidelity = [self.infidelity; optimValues.fval];
         self.state = [self.state; x];
%          self.searchdir  = [self.searchdir ;... 
%                     optimValues.searchdirection'];
    case 'done'
    otherwise
end
 end