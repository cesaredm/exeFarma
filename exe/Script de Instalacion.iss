;******************************************************************************************************************************************
; [Setup]: Es la parte en donde se configura la aplicaci�n.
;******************************************************************************************************************************************
[Setup]
AppName=Farmacia
AppVerName=Farmacia
DefaultGroupName=Farmacia
AppPublisher=CDfarma
AppVersion=1.0
AllowNoIcons=false
AppCopyright=
PrivilegesRequired=admin

; Este es el nombre del archivo exe que se va a generar
OutputBaseFilename=FarmaciaSetup

; Este es el nombre de la carpeta en la cual se guardar�n los archivos para el programa
; (Por lo general es el mismo nombre de la aplicaci�n)
DefaultDirName={pf}\Farmacia

;******************************************************************************************************************************************


;******************************************************************************************************************************************
; [Languages] y [Tasks]: No tocar o modificar las siguientes l�neas
;******************************************************************************************************************************************
; [Languages] = Es el lenguaje por defecto
; [Tasks]     = Es la indicaci�n para crear los �conos necesarios para iniciar el programa y para desinstalarlo
[Languages]
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Tasks]
Name: desktopicon; Description: Create a &desktop icon; GroupDescription: Additional icons:

;******************************************************************************************************************************************


;******************************************************************************************************************************************
; [Files]: Son los archivos que utilizaremos para crear el instalador
;******************************************************************************************************************************************
[Files]

; Nota: Los par�metros: Tienen que ir tal y como aparecen ac�, solo cambiar las rutas C:\ en donde se encuentran los archivos
;       Otra cosa: {sys} = carpeta system de windows
;                  {win} = carpeta windows de windows
;                  {cf}  = carpeta archivos comunes de windows
;                  {tmp} = carpeta temporal de windows
;                  {app} = carpeta donde se va a instalar el programa (fue definida arriba en el par�metro: DefaultDirName= )
; -----------------------------------------------------------------------------------------------------------------------------------------
; Aqu� van los archivos de la aplicaci�n: El .exe y otros que ocupe el programa la aplicaci�n
Source: C:\Users\gallomasgallo\Desktop\1\jar\Farmacia.exe; DestDir: {app}; Flags: ignoreversion
Source: C:\Users\gallomasgallo\Desktop\1\jar\*; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: C:\Users\gallomasgallo\Desktop\1\exe\complmts\proyectoFarmaciaEditada.sql*; DestDir: {tmp}; Flags : ignoreversion deleteafterinstall

;******************************************************************************************************************************************


; Omitir esta linea [INI] - No tocar o modificar la siguiente l�nea
[INI]


;******************************************************************************************************************************************
; [Icons]: Estos son los �conos que el instalador creara en el grupo de programas del sistema de Windows
;******************************************************************************************************************************************
[Icons]

; Nota: Aqu� se incluye: El �cono para abrir el programa
;                        El �cono para desinstalar el programa
;                        El �cono que se ubica en el escritorio
; -----------------------------------------------------------------------------------------------------------------------------------------
; {group} = nombre del grupo de programa que se defini� arriba en el par�metro: DefaultGroupName=
;           (Por lo general es el mismo nombre de la aplicaci�n)
Name: {group}\Farmacia; Filename: {app}\Farmacia.exe; WorkingDir: {app}; IconIndex: 0
Name: {group}\Desinstalar Farmacia; Filename: {uninstallexe}
Name: {userdesktop}\Farmacia; Filename: {app}\Farmacia.exe; Tasks: desktopicon; WorkingDir: {app}; IconIndex: 0

;******************************************************************************************************************************************


;******************************************************************************************************************************************
; [Run]: Estos son los programas que se instalar como complementos de nuestra aplicaci�n
;******************************************************************************************************************************************
[Run]

; Nota: Esto se ejecuta al momento de la instalaci�n de nuestro programa

; Instalamos MySQL
; (Aqu� tenemos que poner el nombre de nuestro motor de base de datos que se encuentra en nuestra carpeta complementos)
;Filename: {src}\complmts\xampp.exe; WorkingDir: {src}\complmts;

;Enciendo los servicio mysql y apache de xampp
;Filename: C:\xampp\xampp_start.exe

; Esto nos permite crear la base de datos
; (Aqu� ponemos el nombre de nuestra base de datos y cambiamos nuestra ruta  C:\ si es necesario)
Filename: C:\xampp\mysql\bin\mysql.exe; Parameters: "-u root -h localhost -e ""create database dbfarmacia CHARACTER SET 'utf8' COLLATE utf8_spanish_ci";  WorkingDir: {tmp}; StatusMsg: Creando la Base dedatos; Flags: runhidden

; Cargamos la base de datos
; (Acedemos a nuestra base de datos, cargamos nuestras tablas coon nuestro arcchivo [.sql] y cambiamos nuestra ruta  C:\ si es necesario)
Filename: C:\xampp\mysql\bin\mysql.exe; Parameters: "-u root -h localhost -e ""use dbfarmacia; source proyectoFarmaciaEditada.sql;";  WorkingDir: {tmp}; StatusMsg: Creando Base de Datos; Flags: runhidden

;apago los servicios de apache 
;Filename: C:\xampp\apache_stop.bat
;******************************************************************************************************************************************


;******************************************************************************************************************************************
; [Messages]: Estos mensajes simplemente son un override ya que vienen en ingl�s
;             (Cambia los valores de las etiquetas para que aparezcan con el nombre de tu aplicaci�n)
;******************************************************************************************************************************************
[Messages]

; Este es el t�tulo que se mostrara al momento de iniciar el cuadro de dialogo de la instalaci�n (Cambia el Nombre_Aplicaci�n por el nombre de tu aplicacion)
WelcomeLabel1=Instalaci�n de Sistema CDfarma

; Este es e� titulo que se mostrara debajo del titulo (Cambia el Nombre_Aplicaci�n por el nombre de tu aplicacion)
WelcomeLabel2=Este proceso instalar� CDfarma.%n%nSe recomienda cerrar todas las aplicaciones abiertas%nantes de continuar.

;******************************************************************************************************************************************