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

% Last Modified by GUIDE v2.5 15-Apr-2015 16:32:13

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


% --- Outputs from this function are returned to the command line.
function varargout = mainGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function menu_Callback(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function funcoes_Callback(hObject, eventdata, handles)
% hObject    handle to funcoes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function abrir_Callback(hObject, eventdata, handles)
% hObject    handle to abrir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [path_file, user_cancel] = imgetfile();
    if ~user_cancel
        handles.arquivo = path_file;
        handles.original = im2uint8(imread(path_file));
        axes(handles.axes1);
        imshow(handles.original);
    end
    handles.px2min = NaN;
    guidata(hObject, handles);


% --------------------------------------------------------------------
function salvar_Callback(hObject, eventdata, handles)
% hObject    handle to salvar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if isfield( handles, 'resultado' )
        [path_file, user_cancel] = imsave();
        if ~user_cancel
            imwrite(handles.resultado, path_file);
            handles.px2min = NaN;
            guidata(hObject, handles);
        end
    else
        msgbox('Imagem Resultado nao foi gerada!', 'Error', 'Error');
    end
% --------------------------------------------------------------------


% --------------------------------------------------------------------
% function questao1_Callback(hObject, eventdata, handles)
% % hObject    handle to questao1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%     if isfield( handles, 'original' )
%         handles.resultado = questao1(handles.original);
%         axes(handles.axes2);
%         imshow(handles.resultado);
%         handles.px2min = NaN;
%         guidata(hObject, handles);
%     else
%         msgbox('Imagem nao foi carregada!', 'Error', 'Error');
%     end


% --------------------------------------------------------------------
% function questao2_Callback(hObject, eventdata, handles)
% % hObject    handle to questao2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%     result = inputdlg('Informe o valor de C:');
%     if ~isempty(result)
%         c = str2double(char(result(1)));
%         if isfield( handles, 'original' )
%             handles.resultado = questao2(handles.original, c);
%             axes(handles.axes2);
%             imshow(handles.resultado);
%             handles.px2min = NaN;
%             guidata(hObject, handles);
%         else
%             msgbox('Imagem nao foi carregada!', 'Error', 'Error');
%         end
%     end



% % --------------------------------------------------------------------
% function questao3_Callback(hObject, eventdata, handles)
% % hObject    handle to questao3 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%     result = inputdlg('Informe o valor de C:');
%     if ~isempty(result)
%         c = str2double(char(result(1)));
%         result = inputdlg('Informe o valor de Gama:');
%         if ~isempty(result)
%             if isfield( handles, 'original' )
%                 gama = str2double(char(result(1)));
%                 handles.resultado = questao3(handles.original, c, gama);
%                 axes(handles.axes2);
%                 imshow(handles.resultado);
%                 handles.px2min = NaN;
%                 guidata(hObject, handles);
%             else
%                 msgbox('Imagem nao foi carregada!', 'Error', 'Error');
%             end
%         end
%     end


% --------------------------------------------------------------------
% function questao4_Callback(hObject, eventdata, handles)
% % hObject    handle to questao4 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%     result = inputdlg('Informe o Plano:');
%     if ~isempty(result)
%         plano = str2double(char(result(1)));
%         if isfield( handles, 'original' )
%             handles.resultado = questao4(handles.original,  plano);
%             axes(handles.axes2);
%             imshow(handles.resultado);
%             handles.px2min = NaN;
%             guidata(hObject, handles);
%         else
%             msgbox('Imagem nao foi carregada!', 'Error', 'Error');
%         end
%     end