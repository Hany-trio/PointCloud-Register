classdef PointCloud_ <handle
    
    
    properties 
        
       Name = ''; 
       pCloud; 
       Feature;
       
    end
       
    
    
    methods			%�����鿪ʼ
  
        function obj = PointCloud_(pc_name,pc_cloud)	%���캯�����ص�Ҳ�Ǻ���ͬ��
            
            obj.Name = pc_name;
            obj.pCloud = pc_cloud;
            
        end
        
        function setFeature(obj , Feature)
            
            obj.Feature = Feature;
            
        end

        
    end				%���������
 



end					%�ඨ�����
