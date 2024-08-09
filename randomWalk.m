% Random Walk Movement Function:
% A separate function for the probability of jumping towards a certain
% direction.

function movement = randomWalk(t)
    % Generate a random walk movement based on the given time
    movement = 2 * (rand - 0.5) * sin(2 * pi * t);
end