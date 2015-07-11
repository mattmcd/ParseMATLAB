function y=test_case(x)

switch x
    case 1
        y=1;
    case 'a'
        y = 2;
    case {'b','c'}
        y = 3;
    otherwise
        y = 4;
end

end
