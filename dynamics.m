function x_next = dynamics(x_prev, dt)
if(size(x_prev)~=18)
    fprintf('Length of a state vector must be 18. Current input length is %d\n', length(x_prev));
    break;
end


end