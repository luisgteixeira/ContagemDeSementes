function varargout = mainGUI(varargin)
% PRATICA01GUI MATLAB code for pratica01GUI.fig
%      PRATICA01GUI, by itself, creates a new PRATICA01GUI or raises the existing
%      singleton*.
%
%      H = PRATICA01GUI returns the handle to a new PRATICA01GUI or the handle to
%      the existing singleton*.
%
%      PRATICA01GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRATICA01GUI.M with the given input arguments.
%
%      PRATICA01GUI('Property','Value',...) creates a new PRATICA01GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pratica01GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pratica01GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pratica01GUI

% Last Modified by GUIDE v2.5 27-Apr-2016 21:07:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @mainGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
end


% --- Executes just before pratica01GUI is made visible.
function mainGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pratica01GUI (see VARARGIN)

% Choose default command line output for pratica01GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pratica01GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end


% --- Outputs from this function are returned to the command line.
function varargout = mainGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


% --------------------------------------------------------------------
function menu_Callback(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


% --------------------------------------------------------------------
function abrir_Callback(hObject, eventdata, handles)
% Funcao para abrir uma imagem

    global imgsArray   % Array com todas as imagens
    imgsArray = [];
    
    global count   % Contador referencia fase atual do processo
    count = 1;
    
    [path_file, user_cancel] = imgetfile();
    if ~user_cancel
        handles.arquivo = path_file;
        handles.atual = im2uint8(imread(path_file));
        imgsArray{count} = handles.atual;
        trocaHandles( hObject, handles );
    end
    handles.px2min = NaN;
    guidata(hObject, handles);
end


% --------------------------------------------------------------------
function salvar_Callback(hObject, eventdata, handles)
% hObject    handle to salvar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imgsArray
global count

    if ~isempty(count)
        [path_file, user_cancel] = imsave();
        if ~user_cancel
            imwrite(imgsArray{count}, path_file);
            handles.px2min = NaN;
            guidata(hObject, handles);
        end
    else
        msgbox('Imagem Atual nao foi gerada!', 'Error', 'Error');
    end
end
% --------------------------------------------------------------------


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global imgsArray
    global count
    count = count + 1;

    switch count
        case 2
            % Soma as bandas H e V do sistema de cor HSV %
            if isfield( handles, 'atual' )
                imgsArray{count} = preProcessamento(imgsArray{count - 1});
                trocaHandles(hObject, handles);
            else
                msgbox('Imagem nao foi carregada!', 'Error', 'Error');
            end

        case 3
            % --- Segmenta a imagem utilizando o Kmeans --- %
            if isfield( handles, 'atual' )
                imgsArray{count} = segmentacao(imgsArray{count - 1});
                trocaHandles(hObject, handles);
            else
                msgbox('Imagem nao foi carregada!', 'Error', 'Error');
            end

        otherwise
            [escolha, tam] = esolhaMM;
            disp(strcat('Escolha:', escolha));
            disp(strcat('Tamanho:', tam));
            if tam > 0
                if strcmp(escolha, 'Erosao')
                    imgsArray{count} = erode(imgsArray{count - 1}, tam);
                    trocaHandles(hObject, handles);
                elseif strcmp(escolha, 'Dilatacao')
                    imgsArray{count} = dilata(imgsArray{count - 1}, tam);
                    trocaHandles(hObject, handles);
                end
            end

    end
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

    global imgsArray
    global count

    % Nao tenta retirar a imagem lida
    if count > 1    
        imgsArray{count} = [];  % Apaga imagem atual do array
        count = count - 1;      % Volta 1 imagem

        % Troca imagem atual pela anterior e anterior por uma mais anterior ainda
        trocaHandles(hObject, handles);
    end
end


function trocaHandles(hObject, handles)
    global count
    global imgsArray
    
    if count > 1
        % Imagem Anterior
        axes(handles.axes1);
        imshow(imgsArray{count - 1});
        handles.px2min = NaN;
        guidata(hObject, handles);
        
        % Imagem Atual
        axes(handles.axes2);
        imshow(imgsArray{count});
        handles.px2min = NaN;
        guidata(hObject, handles);
    elseif count == 1
        % Imagem Anterior
        axes(handles.axes1);
        imshow([]);
        handles.px2min = NaN;
        guidata(hObject, handles);
        
        % Imagem Atual
        axes(handles.axes2);
        imshow(imgsArray{count});
        handles.px2min = NaN;
        guidata(hObject, handles);
    end
end


function [escolha, tam] = esolhaMM
    d = dialog('Position',[300 300 245 150],'Name','Pos processamento');
    txt1 = uicontrol('Parent',d,...
           'Style','text',...
           'Position',[10 80 80 30],...
           'String','Tipo de MM:');
       
    popup = uicontrol('Parent',d,...
           'Style','popup',...
           'Position',[10 70 100 25],...
           'String',{'Erosao';'Dilatacao'},...
           'Callback',@popup_callback);
       
    txt2 = uicontrol('Parent',d,...
           'Style','text',...
           'Position',[120 80 110 30],...
           'String','Tamanho do EL:');
       
    edit = uicontrol('Parent',d,...
           'Style','edit',...
           'Position',[120 70 40 25],...
           'String','0',...
           'Callback',@edit_callback);
       
    btn = uicontrol('Parent',d,...
           'Position',[89 20 70 25],...
           'String','Ok',...
           'Callback','delete(gcf)');
       
    escolha = 'Erosao';
    tam = '0';
       
    % Wait for d to close before running to completion
    uiwait(d);
   
    function popup_callback(popup,callbackdata)
        % idx = popup.Value;
        % popup_items = popup.String;
        % This code uses dot notation to get properties.
        % Dot notation runs in R2014b and later.
        % For R2014a and earlier:
        idx = get(popup,'Value');
        popup_items = get(popup,'String');
        escolha = char(popup_items(idx,:));
    end

    function edit_callback(edit,callbackdata)
        text = get(edit,'String');
        tam = round(str2double(text));
    end
end
