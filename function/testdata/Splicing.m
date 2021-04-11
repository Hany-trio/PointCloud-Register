function [T] = Splicing(pc1,pc2,pc1i_,pc2i_,tag)
    
    %% ���������� �����������ݼ� �Լ�����֮��Ķ�Ӧ�ߣ�������֮��ı任��ϵ
    
    % ��֤ pc1 Ϊ Refer
    %      pc2 Ϊ Match
      
    Line1 = pc1.Lines(pc1i_).Line; 
    Normal1 = pc1.Lines(pc1i_).Normal; 
    Line2 = pc2.Lines(pc2i_).Line; 
    Normal2 = pc2.Lines(pc2i_).Normal; 
    
%   HCode_NICP(Refer_cloud,Match_cloud,Refer_Normal,Match_Normal)
    % ���� �� ���� 1 2 �ļ��� ���أ� T �任����
    % Refer_cloud �ο����� N*3 �����任����
    % Match_cloud ƥ����� N*3 ���任����
    % Refer_Normal �ο����Ʒ��� N*3
    % Match_Normal ƥ����Ʒ��� N*3
      
    if strcmp(tag ,'NICP')
    
        [T] =  HCode_NICP(Line1,Line2,Normal1,Normal2);
        
    end
    
    if strcmp(tag ,'ICP')
       
       [T] = n_ICP(Line1,Line2);
        
    end


end

