#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <IE.au3>
#include <ScreenCapture.au3> ; UDF para capturar pantalla

; Ruta al archivo HTML (cámbiala por la tuya)
Local $htmlFile = @ScriptDir & "\firma.svg"
Local $capturePath = @UserProfileDir & "\Downloads\firma.jpg" ; Ruta donde se guardará la captura

; Crear una GUI para mostrar el HTML
Local $hGUI = GUICreate("Firmar", 400, 350, @DesktopWidth/2-400, @DesktopHeight/2-300, $WS_OVERLAPPEDWINDOW + $WS_VISIBLE + $WS_CLIPSIBLINGS)
Local $oIE = _IECreateEmbedded()
Local $hIE = GUICtrlCreateObj($oIE, 0, 0, 400, 300)
_IENavigate($oIE, "file://" & $htmlFile)

; Botón para capturar la pantalla
Local $hButton = GUICtrlCreateButton("Captura Pantalla", 105, 310, 200, 30)
GUICtrlSetBkColor($hButton, 0x00FF00) ; Fondo verde
GUICtrlSetColor($hButton, 0x000000)   ; Texto blanco

GUISetState(@SW_SHOW)

; Bucle principal
While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $hButton
            ; Capturar la ventana del control WebBrowser
            _ScreenCapture_CaptureWnd($capturePath, $hGUI, 0, 25, 399, 324)
            MsgBox(0, "Captura", "Captura guardada a: " & $capturePath)

            ; Copiar firma.jpg desde Downloads a la carpeta del script
            Local $var = @UserProfileDir & "\Downloads"
            FileCopy($var & "\firma.jpg", @ScriptDir & "\firma.jpg", 1)

            ; Eliminar el archivo original de Downloads
            FileDelete($var & "\firma.jpg")
  
            ; Cerrar la GUI y salir del script
            GUIDelete($hGUI)
            Exit
    EndSwitch
WEnd

