CLOSE DATA
* AGREGA REGISTROS ARBAIIBB DESDE TXT *

USE ret.dbf ALIAS RETIIBB IN 0
USE per.dbf ALIAS PERIIBB IN 0

SET CENTURY ON 

SELE RETIIBB
		DELE ALL
		PACK
		WAIT WIND 'AGREGANDO RETENCIONES' NOWAIT
		APPEND FROM C:\PADRON\retencion.txt type delimited WITH CHARACTER ";"

		IF TAG(1) = 'CUIT' 
			SET ORDER TO TAG CUIT
		ELSE
			index on cuit tag CUIT
		ENDIF
		
		WAIT CLEAR

		
SELE PERIIBB
		DELE ALL
		PACK
		WAIT WIND 'AGREGANDO PERCEPCIONES' NOWAIT
		APPEND FROM C:\PADRON\percepcion.txt type delimited WITH CHARACTER ";"

		IF TAG(1) = 'CUIT' 
			SET ORDER TO TAG CUIT
		ELSE
			index on cuit tag CUIT
		ENDIF

		WAIT CLEAR

close data

use ret.dbf alias retiibb  in 0 order CUIT
use per.dbf alias periibb  in 0 order CUIT
use iibb.dbf in 0

SELE IIBB
DELE ALL
PACK
		WAIT WIND 'CARGANDO DATOS' NOWAIT

do while !eof('retiibb')

		
		m.cuit=retiibb.cuit
		=seek(m.cuit,'periibb')

		m.fecha=periibb.fecha
		m.fedesde=retiibb.fedesde
		m.fehasta=retiibb.fehasta

		m.ticoin=retiibb.ticoin
		m.altabaja=retiibb.altabaja
		m.caalicuota=periibb.caalicuota

		m.retencion=retiibb.alicuota
		m.percepcion=periibb.alicuota
		m.grupoper=periibb.grupoper
		m.gruporet=retiibb.gruporet

		m.sep1=';'
		m.sep2=';'
		m.sep3=';'
		m.sep4=';'
		m.sep5=';'
		m.sep6=';'
		m.sep7=';'
		m.sep8=';'
		m.sep9=';'
		m.sep10=';'
		m.sep11=';'

		append blank
		gather memvar
		skip in retiibb		

enddo

		WAIT WIND 'GENERANDO PADRON.txt' NOWAIT
		COPY TO C:\PADRON\padron.txt Type SDF
		WAIT CLEAR

CLOSE DATA
RETURN