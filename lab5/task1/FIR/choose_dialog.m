function [choice,PassBand,StopBand] = choosedialog

    d = dialog('Position',[300 300 450 300],'Name','Select One');

    txt0 = uicontrol('Parent',d,'Style','text','Position',[0 250 210 40],...
           'String','Choose Design Method');

    popup0 = uicontrol('Parent',d,'Style','popup','Position',[30 240 100 25],...
           'String',{'Bartlett';'Blackman';'Boxcar';'Chebyshev';'Hamming';'Hann';'Hanning';'Kaiser';'Taylor';'Triang';'User Defined'},...
           'Callback',@popup_callback1);

    popup1 = uicontrol('Parent',d,'Style','edit','Position',[100 190 300 25],'Callback',@popup_callback2);

     txt1 = uicontrol('Parent',d,'Style','text','Position',[0 170 100 40],...
           'String','Pass Bands');

    popup2 = uicontrol('Parent',d,'Style','edit','Position',[100 140 300 25],'Callback',@popup_callback3);

     txt2 = uicontrol('Parent',d,'Style','text','Position',[0 120 100 40],...
           'String','Stop Bands');

    btn = uicontrol('Parent',d,'Position',[350 30 70 25],'String','Continue',...
           'Callback','delete(gcf)');

    % Wait for d to close before running to completion
    uiwait(d);

       function popup_callback1(popup0,event)
          num = popup0.Value;
          popup_items = popup0.String;
          choice = char(popup_items(num,:));
        end

        function popup_callback2(popup1,event)
            PassBand = get(popup1,'String')
        end

        function popup_callback3(popup2,event)
            StopBand = get(popup2,'String')
        end
end
