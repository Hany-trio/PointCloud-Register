classdef PointCloud_ <handle
    
    
    properties 
        
       Name = ''; 
       pCloud; 
       Feature;
       
    end
       
    
    
    methods			%方法块开始
  
        function obj = PointCloud_(pc_name,pc_cloud)	%构造函数，特点也是和类同名
            
            obj.Name = pc_name;
            obj.pCloud = pc_cloud;
            
        end
        
        function setFeature(obj , Feature)
            
            obj.Feature = Feature;
            
        end

        
    end				%方法块结束
 



end					%类定义结束
