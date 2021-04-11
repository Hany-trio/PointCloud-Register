function Tran_pc = TransForm_Dataset( pc , T )
    
    Tran_pc.CloudPoint = Transform_cp( pc.CloudPoint , T );
    Tran_pc.CloudBoundary = Transform_cp( pc.CloudBoundary , T );
    Tran_pc.TurningPoint = Transform_cp( pc.TurningPoint , T );
    
    [ ~ , l ] = size(pc.Lines);
    
    
    for i = 1 : l
       
        Tran_pc.Lines(i).TurningPoint = pc.Lines(i).TurningPoint;
        Tran_pc.Lines(i).Line  = Transform_cp( pc.Lines(i).Line , T );
        Tran_pc.Lines(i).Normal  = Transform_cp( pc.Lines(i).Normal , T );
        
    end
    


end



function p = Transform_cp(p,T)     % 旋转一个维度为3的点集/法线集
       
	[l,w] = size(p);
        
	if  ( l > 3 )
           
        p  = p';
        [ ~ , w ] = size( p );
            
	end
        
	p = [ p ; ones(1,w) ];
        
	p = ( T * p )';
        
	p = p(:,1:3);

    
end