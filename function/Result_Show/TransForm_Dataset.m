function Tran_pc = TransForm_Dataset( pc , T )
    
    Tran_pc = pc;
    Tran_pc.Feature.Transed = Transform_cp( pc.pCloud.Location , T );
    Tran_pc.Feature.Boundaryinformation.BoundaryPoints = Transform_cp( pc.Feature.Boundaryinformation.BoundaryPoints , T );
    Tran_pc.Feature.TurningPoint.Points = Transform_cp( pc.Feature.TurningPoint.Points , T );
    
    [ ~ , l ] = size(pc.Feature.SubBoundaryInformation.Points);
    
    
    for i = 1 : l
       
        Tran_pc.Feature.SubBoundaryInformation.Points(i).TrPoint = Transform_cp( pc.Feature.SubBoundaryInformation.Points(i).TrPoint,T);
        Tran_pc.Feature.SubBoundaryInformation.Points(i).Line  = Transform_cp( pc.Feature.SubBoundaryInformation.Points(i).Line , T );
        Tran_pc.Feature.SubBoundaryInformation.Points(i).Normal  = Transform_cp( pc.Feature.SubBoundaryInformation.Points(i).Normal , T );
        
    end
    


end



function p = Transform_cp(p,T)     % 旋转一个维度为3的点集/法线集
       
	[l,w] = size(p);
        
	if  ( l ~= 3 )
           
        p  = p';
        [ ~ , w ] = size( p );
            
	end
        
	p = [ p ; ones(1,w) ];
        
	p = ( T * p )';
        
	p = p(:,1:3);

    
end