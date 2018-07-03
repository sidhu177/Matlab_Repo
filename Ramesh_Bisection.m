function [x,fr,itrCount,stat] = Ramesh_Bisection(fName, l, r, xTol, fTol, itrLimit, verbose)

Terminate = false;
itrCount = 0;
x = NaN;
fr = NaN; 
stat = 1;    

fLeft = feval(fName, l);
fRight = feval(fName, r);

if (sign(fLeft) == sign(fRight)) && (sign(fLeft) ~= 0)
   %fprintf('Error: function values agree in sign at interval end points\n')
   return;
else
   while Terminate == false
      if verbose
         %fprintf('Iteration %d: interval is [%f, %f]; best function value is %f\n',itrCount, l, r, min(abs(fLeft), abs(fRight)))
      end
      if abs(fLeft) < fTol
         x = l;
         fr = fLeft;
         stat = 0;
         Terminate = true;
      elseif abs(fRight) < fTol
         x = r;
         fr = fRight;
         stat = 0;
         Terminate = true;
      elseif (abs(fLeft) >= fTol) && (abs(fRight) >= fTol)
         xMid = (l+r)/2;
         fMid = feval(fName, xMid);
         if abs(r-l) < xTol
            x = xMid;
            fr = fMid;
            stat = 0;
            Terminate = true;
         elseif abs(r-l) >= xTol
            
            if itrCount >= itrLimit
               
               if abs(fLeft) < abs(fRight)
                  x = l;
                  fr = fLeft;
                  Terminate = true;
               elseif abs(fLeft) >= abs(fRight)
                  x = r;
                  fr = fRight;
                  Terminate = true;
               else
                  %fprintf('Error: unable to compare function values\n')
                  return;
               end
            elseif itrCount < itrLimit
               itrCount = itrCount + 1;
               
               if (sign(fMid) == sign(fLeft)) || (sign(fMid) == 0)
                  l = xMid;
                  fLeft = fMid;
               elseif (sign(fMid) == sign(fRight)) && (sign(fMid) ~= 0)
                  r = xMid;
                  fRight = fMid;
               else
                  %fprintf('Error: Unable to idenfity change in sign at end points\n')
                  return;
               end
            else
               %fprintf('Error: itrCount does not compare with the iteration limit.\n')
               return;
            end
         else
            %fprintf('Error: Unable to idenfity interval width\n')
         end
      else
         %fprintf('Error: Unable to compare to function tolorance\n')
         return;
      end
   end 
end







