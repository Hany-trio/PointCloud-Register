function [so] = SOTransformso(T)
    
    R = T(1:3,1:3);
    selta_ = (trace(R)-1)/2;
    selta = acos(selta_);
    
    deg = selta / pi*180 
    
%     [A,B] = eig(R);
    
%     if( B(1,1) < 1.0002 && B(1,1) > 0.999)
%         
%         a = A(:,1);
%         
%     end
    
    deltat =  T(1:3,4);
    deltat = norm( deltat )
    
%     so = selta * a;    
%     
%     R = cos(selta)*eye(3)+(1-cos(selta))*(a*a')+sin(selta)*ToAntisymmetric_Mat(a);
  
end

function [Mat] = ToAntisymmetric_Mat(vector)
    
    [ w , ~ ] = size(vector);
    
    if(w ~= 3)
        
        vector = vector';
        
    end
       
    a1 = vector(1,1);
    a2 = vector(2,1);
    a3 = vector(3,1);
    
    
    Mat = [ 0  , -a3 ,  a2;
            a3 ,  0  , -a1;
           -a2 ,  a1 ,  0];

end

