function [t] = GoalTest(State,GoalState)

%GoalState = [10 10];

if (State==GoalState)
	t = 1;
else
	t = 0;
end

end
