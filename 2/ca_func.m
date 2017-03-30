function x1 = ca_func(x0, rule)

x0 = bin2dec(x0);

switch x0
    case 7
        x1 = rule(1);
    case 6
        x1 = rule(2);
    case 5
        x1 = rule(3);
    case 4
        x1 = rule(4);
    case 3
        x1 = rule(5);
    case 2
        x1 = rule(6);
    case 1
        x1 = rule(7);
    case 0
        x1 = rule(8);
end
% if (x0(1) == 1)
%     if (x0(2) == 1)
%         if (x0(3) == 1)
%             x1 = rule(1);
%         else
%             x1 = rule(2);
%         end
%     else
%         if (x0(3) == 1)
%             x1 = rule(3);
%         else
%             x1 = rule(4);
%         end
%     end
% else
%     disp('hej')
%     if (x0(2) == 1)
% disp('hej')
%         if (x0(3) == 1)
%             disp('hej')
%             x1 = rule(5);
%         else
%             x1 = rule(6);
%         end
%     else
%         if (x0(3) == 1)
%             x1 = rule(7);
%         else
%             x1 = rule(8);
%         end
%     end
% end

end