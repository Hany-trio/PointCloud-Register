function [pc] = Spliced(pc1,pc2,indxpc1,indxpc2)
    
    Linenum = 1; 

    pc.CloudPoint = [pc1.CloudPoint;pc2.CloudPoint];
    
    A_pc1 = pc1.Lines(indxpc1).TurningPoint; 
    A_pc2 = pc2.Lines(indxpc2).TurningPoint; 
    
    A1 = A_pc1(1);B1 = A_pc1(2);
    A2 = A_pc2(1);B2 = A_pc2(2);
    
    for i = 1 : length(pc1.Lines)
       
        if (i == indxpc1)
            
            continue;
            
        end
        
        if( isempty(find(pc1.Lines(i).TurningPoint == A1)) && isempty(find(pc1.Lines(i).TurningPoint == B1)) )
        
%             pc.Line( Linenum ) = pc1.Lines(i).TurningPoint;
            pc.Lines( Linenum ).Line = pc1.Lines(i).Line;
            pc.Lines( Linenum ).Normal = pc1.Lines(i).Normal;
            Linenum = Linenum + 1; 
            
        end
        
        if( ~isempty(find(pc1.Lines(i).TurningPoint == A1)) )
        
%             pc.Line( Linenum ) = pc1.Lines(i).TurningPoint;
            A1_cp1_Line = i;
            
        end
        
        if( ~isempty( find(pc1.Lines(i).TurningPoint == B1) ) )
        
%             pc.Line( Linenum ) = pc1.Lines(i).TurningPoint;
            B1_cp1_Line = i;
            
        end        
            
    end
    
    
	for i = 1 : length(pc2.Lines)
        
        if (i == indxpc2)
            
            continue;
            
        end
       
        if( isempty(find(pc2.Lines(i).TurningPoint == A2)) && isempty(find(pc2.Lines(i).TurningPoint == B2)) )
        
%             pc.Line( Linenum ) = pc1.Lines(i).TurningPoint;
            pc.Lines( Linenum ).Line = pc2.Lines(i).Line;
            pc.Lines( Linenum ).Normal = pc2.Lines(i).Normal;
            Linenum = Linenum + 1; 
            
        end
        
         if( ~isempty(find(pc2.Lines(i).TurningPoint == A2)) )
        
%             pc.Line( Linenum ) = pc1.Lines(i).TurningPoint;
            A2_cp2_Line = i;
            
        end
        
        if( ~isempty(find(pc2.Lines(i).TurningPoint == B2)) )
        
%             pc.Line( Linenum ) = pc1.Lines(i).TurningPoint;
            B2_cp2_Line = i;
            
        end
            
	end
        
    Cloud1 = pc1.CloudPoint ;
    Cloud2 = pc2.CloudPoint ;
    
    A1_Point = Cloud1(A1,:);
    B1_Point = Cloud1(B1,:);
    A2_Point = Cloud2(A2,:);
    B2_Point = Cloud2(B2,:);
        
    if (norm(A1_Point-A2_Point) < 0.02) %说明A1与A2是对应点  
        
        pc.Lines( Linenum ).Line = [ pc1.Lines(A1_cp1_Line).Line ; pc2.Lines(A2_cp2_Line).Line ];
        pc.Lines( Linenum ).Normal = [ pc1.Lines(A1_cp1_Line).Normal ; pc2.Lines(A2_cp2_Line).Normal ];
        Linenum = Linenum + 1; 
        pc.Lines( Linenum ).Line = [ pc1.Lines(B1_cp1_Line).Line ; pc2.Lines(B2_cp2_Line).Line ];
        pc.Lines( Linenum ).Normal = [ pc1.Lines(B1_cp1_Line).Normal ; pc2.Lines(B2_cp2_Line).Normal ];
        
    else % 说明A1 与 B2 是对应点
        
        pc.Lines( Linenum ).Line = [ pc1.Lines(A1_cp1_Line).Line ; pc2.Lines(B2_cp2_Line).Line ];
        pc.Lines( Linenum ).Normal = [ pc1.Lines(A1_cp1_Line).Normal ; pc2.Lines(B2_cp2_Line).Normal ];
        Linenum = Linenum + 1; 
        pc.Lines( Linenum ).Line = [ pc1.Lines(B1_cp1_Line).Line ; pc2.Lines(A2_cp2_Line).Line ];
        pc.Lines( Linenum ).Normal = [ pc1.Lines(B1_cp1_Line).Normal ; pc2.Lines(A2_cp2_Line).Normal ];
        
    end
    
    pc.CloudBoundary = [];
    for i = 1 : Linenum
        
        pc.CloudBoundary = [ pc.CloudBoundary ; pc.Lines(i).Line ];
    
    end
     
     
    
    



end

