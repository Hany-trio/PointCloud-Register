function [T] = Splicing(pc1,pc2,pc1i_,pc2i_,tag)
    
    %% 大致作用是 导入两个数据集 以及他们之间的对应边，求它们之间的变换关系
    
    % 保证 pc1 为 Refer
    %      pc2 为 Match
      
    Line1 = pc1.Lines(pc1i_).Line; 
    Normal1 = pc1.Lines(pc1i_).Normal; 
    Line2 = pc2.Lines(pc2i_).Line; 
    Normal2 = pc2.Lines(pc2i_).Normal; 
    
%   HCode_NICP(Refer_cloud,Match_cloud,Refer_Normal,Match_Normal)
    % 输入 ： 点云 1 2 文件； 返回： T 变换矩阵
    % Refer_cloud 参考点云 N*3 不做变换操作
    % Match_cloud 匹配点云 N*3 做变换操作
    % Refer_Normal 参考点云法线 N*3
    % Match_Normal 匹配点云法线 N*3
      
    if strcmp(tag ,'NICP')
    
        [T] =  HCode_NICP(Line1,Line2,Normal1,Normal2);
        
    end
    
    if strcmp(tag ,'ICP')
       
       [T] = n_ICP(Line1,Line2);
        
    end


end

