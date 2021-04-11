function [Boundary_] = Boundary_NoiseElimination(Pt,Boundary)
     
    
    BoundaryPs = Pt(Boundary(:,2),1:3);
    
    kdtreeobj = KDTreeSearcher( BoundaryPs ,'distance' , 'euclidean' ); %KDTREE

    NumBoundaryP = length(BoundaryPs); 
    
    indx = false(NumBoundaryP,1);
    
    for i = 1 : NumBoundaryP
        
       [ idx , ~ ]=knnsearch(kdtreeobj,BoundaryPs(i,1:3),'dist','euclidean','k', 5 );  % аз╫Э╣Ц
       norm(sum(BoundaryPs(idx,1:3)))
       
       if( norm(sum(BoundaryPs(idx,1:3))) < 0.6147)
           
           indx(i,1) = true; 
           
       end
        
    end
    
    Boundary_ = Boundary(indx,:);    


end

