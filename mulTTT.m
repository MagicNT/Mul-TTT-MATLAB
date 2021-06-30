

%//##################################//
%//##################################//
%//#@#//                        //#@#// 
%//#@#// TITLE:  MulTiTicTacToe //#@#// 
%//#@#// AUTHOR: TONY NASR      //#@#// 
%//#@#//                        //#@#// 
%//##################################//
%//##################################//


function [] = mulTTT()

    clc;
    clear;
    close all;

    while (1)
      x_player = inputdlg ("        X Player, Type In Your Name: ", "Lets Get To Know Each Other"); 
      a     = x_player{1};
      if (strcmp(a, "") ~= 1)
        break;
      endif    
      warndlg ("Must Type A Name!")
    endwhile

    while (1)
      o_player = inputdlg ("        O Player, Type In Your Name: ", "Lets Get To Know Each Other"); 
      a     = o_player{1};
      if (strcmp(a, "") ~= 1)
        break;
      endif    
      warndlg ("Must Type A Name!")
    endwhile


    while (1)
        c     = inputdlg ("               Choose A Color for The O: \n\n 1 --> Green \n 2 --> Blue \n 3 --> red \n\n", "Choose A Color");
        a     = c{1};
        if (strcmp(a, "") ~= 1)       
          cho    = str2num(a);
          if (cho >= 1 && cho <= 3)
             c = cho;
             break;           
          endif   
        endif   
      warndlg ("Must Choose One of These colors!")
    endwhile
    
    while (1)
        s = inputdlg ("               Type In The Board Size: \n\n", "Choose A Baord Size");
        ch     = s{1};
        if (strcmp(ch, "") ~= 1)       
          cho    = str2num(ch);
          if (cho >= 3)
             s = cho;
             break;           
          endif   
        endif
        warndlg ("Please Choose A Valid Number >= 3")          
    endwhile
    
    X_player = strcat (x_player, " 's Turn (X)");
    O_player = strcat (o_player, " 's Turn (O)");   
    
    close all;
    figure ('Name', 'Tic Tac Toe Game Board');
    axis([0 s 0 s])
    set (gca, 'xTick', 0:s)
    set (gca, 'yTick', 0:s)
    set (gca, 'Color', 'y')    
    set (gca, 'xTickLabel', 'X/O')
    set (gca, 'yTickLabel', 'X/O')
    title (X_player)   
    grid on
    is_x = 1; 
    state = -1 * ones(s);
    winner = -1;
    
    while winner == -1
      next = play (is_x, state, s, c); 
      if next == -1 
        title('Not Allowed To Do This  Move, Please Choose Again ');
      else
        state = next;
        title('');
        is_x = mod (is_x + 1,2);
        if is_x == 1
          title (X_player);
        else
          title (O_player);
        endif
          winner = result (state, s);
        endif
        state'
    endwhile
    
    if winner == 0    
      title('WE HAVE A WINNER');
      msgbox(strcat ('  WE HAVE A WINNER ........... ', o_player,' (O)'));        
      xlabel('');        
    elseif winner == 1 
      title('WE HAVE A WINNER');
      msgbox(strcat ('  WE HAVE A WINNER ........... ', x_player,' (X)'));            
      xlabel('');
    else 
      title('WE HAVE A SUDDEN DEATH !!');
      msgbox('  WE HAVE A SUDDEN DEATH ........... Its a Tie');          
      xlabel('');
    endif
    
    while (1)
      again = inputdlg ("        Play Another Match ? (yes/no) ", "Lets Play Again !!");    
      a     = again{1};
      if (strcmp(a, "yes") == 1)
        close all;
        mulTTT();
      elseif (strcmp(a, "no") == 1)
        close all;
        break;
      endif    
      warndlg ("Must Type in yes OR no only !")
    endwhile

endfunction


function state = play (is_x, state, s, c)
  
    [x     y] = ginput(1);
    [col row] = position(x, y); 
    row = (s-1) - row; 
    if ((row+1) <=0 || (row+1) > s || (col+1) <= 0 || (col+1) > s)
      state = -1;
    elseif (state(col+1, row+1) ~= -1) 
      state = -1; 
    else
      state (col+1, row+1) = is_x;
      if is_x
        print_X (col, (s-1) - row);
      else
        print_O (col, (s-1) - row, c);
      endif
    endif
endfunction



function result = result (state, s) 
  
    for i = 1:s;
      count = 0;      
      for j = 1:s;
          if (state(i,j) ~= state(i,1))
            break;
          else
            count = count +1;  
          endif
      endfor
      if (count == s && state(i,1) ~= -1)
         result = state (i,1);
         return;
      endif           
    endfor

    state = state';
    for i = 1:s;
      count = 0;      
      for j = 1:s;
          if (state(i,j) ~= state(i,1))
            break;
          else
            count = count +1;  
          endif
      endfor
      if (count == s && state(i,1) ~= -1)
         result = state (i,1);
         return;
      endif           
    endfor    
    
    if  (state(1,1) ~=-1)
       DIAG = diag(state)'
       res = (DIAG == ones(1,s));
       if (sum(res) == s)
         result = state (1,1);
         return;
       endif
       res = (DIAG == 0*ones(1,s));
       if (sum(res) == s)
         result = state (1,1);
         return;
       endif         
    endif  
    
    state = fliplr(state);
    if  (state(1,1) ~=-1)
       DIAG = diag(state)'
       res = (DIAG == ones(1,s));
       if (sum(res) == s)
         result = state (1,1);
         return;
       endif      
       res = (DIAG == 0*ones(1,s));
       if (sum(res) == s)
         result = state (1,1);
         return;
       endif         
    endif      
    
    if ~ismember (state, -1)
      result = 2;
    else
      result = -1;
    endif    
    
endfunction



function [col row] = position(x, y)
  
    col = floor(x);
    row = floor(y);

endfunction

function print_X (col, row)
  
    hold on
    x = 0:1;
    pos = 0:1;
    neg = 1-x;
    plot (x+col, pos+row, 'r')
    plot (x+col, neg+row, 'r')
    hold off
endfunction

function print_O (col, row, c)

    if (c == 1)
      m = 'g';
    elseif (c == 2)
      m = 'b';
    else
     m = 'r'; 
    endif 
    hold on
    t = 0:0.1:2*pi;
    x = cos(t)/2+0.5;
    y = sin(t)/2+0.5;
    fill(x+col, y+row, m)
endfunction





