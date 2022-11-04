/*
 * Recordar que podes usar el between
 * En el método daNuevasSemillas() de Soja te faltaron los paréntesis para agrupar correctamente las condiciones.  
 * La condicion de ```bool and (bool or bool)``` es distinto que ``` bool and bool or bool```  
 */
import parcelas.*

class Planta {
	var property anioDeObtencion
	var property altura //en metros cuadrados
	
	method cuantasHsDeSolTolera () 
	
	method esFuerte() {
		return self.cuantasHsDeSolTolera () > 10
	} 
	method daNuevasSemillas() {return self.esFuerte()
	}
	
	method cuantoEspacioOcupa()
	method esParcelaIdeal(unaParcela)
	method buenaAsociacion(unaParcela){return (self.esParcelaEcologica(unaParcela) or self.esParcelaIndustrial(unaParcela))}
	method esParcelaEcologica(unaParcela){return (not unaParcela.tieneComplicaciones() and self.esParcelaIdeal(unaParcela))}
	method esParcelaIndustrial(unaParcela){return unaParcela.cantidadDePlantas() <=2 and self.esFuerte()}
	
}


class Menta inherits Planta{
	//Tolera seis horas de sol al día. Como condición alternativa para saber si da semillas, hay que mirar si su altura es mayor a 0.4 metros. 
	//Como crece al ras del suelo, diremos que el espacio que ocupa es su altura multiplicada por 3.

	override method cuantasHsDeSolTolera() {
		return 6
	}
	// esFuerte() esta en la superClase
	override method daNuevasSemillas() {return super() or altura > 0.4}
	override method cuantoEspacioOcupa() = altura * 3
	override method esParcelaIdeal(unaParcela){return unaParcela.superficie()>6}
	
}

class Soja inherits Planta{
	//La tolerancia al sol depende de su altura:
	//menor a 0.5 metros: 6 horas;
    //entre 0.5 y 1 metro: 7 horas;
    //más de 1 metro: 9 horas;
	//La condición alternativa para que de semillas es su propia semilla sea de obtención reciente (posterior al 2007) y además su altura sea de más de 1 metro. El espacio que ocupa es la mitad de su altura.


	override method cuantasHsDeSolTolera() { 
		if (altura < 0.5) return 6
		else if (altura.between(0.5,1)) return 7
		else return 9
	}
	// esFuerte() esta en la superClase
	override method daNuevasSemillas() {return super() or (anioDeObtencion > 2007 and altura > 1)}
	override method cuantoEspacioOcupa() = altura / 2
	override method esParcelaIdeal(unaParcela){ return unaParcela.hsDeSol() == self.cuantasHsDeSolTolera()}
}


class Quinoa inherits Planta{
	//Existen muchas cepas de esta nutritiva planta andina y es por eso que la cantidad de horas de sol que tolera la configuraremos para cada planta. 
	//Ocupa siempre 0.5 metros cuadrados y la condición alternativa para saber si da semillas es que el año de obtención de la semilla que le dio origen sea anterior al 2005.
	
	var property horasDeSol
	
	override method cuantasHsDeSolTolera(){return self.horasDeSol()}
	override method daNuevasSemillas() {return super() or anioDeObtencion < 2005}
	override method cuantoEspacioOcupa() {return 0.5}
	override method esParcelaIdeal(unaParcela){ return unaParcela.ningunaSuperalos1coma5()}
}

//Agregar al modelo la soja transgénica y la hierbabuena, que son similares a la soja y a la menta respectivamente, pero con algunas diferencias.

class SojaTransgenica inherits Soja{
	//La soja transgénica nunca da nuevas semillas, porque las empresas que las comercializan las someten adrede a un proceso de esterilización
	// (que les asegura no perder nunca a su clientes). Ojo: la consulta siempre tiene que dar falso, incluso si se cumple la condición general.
	override method daNuevasSemillas() {return false}
	override method esParcelaIdeal(unaParcela){return unaParcela.cantidadMaximaDePlantasQueTolera()==1}
}

class Hierbabuena inherits Menta{
	//La hierbabuena se diferencia de la menta en que se esparce más rápido y por eso el espacio que ocupa es el doble del que ocuparía una planta de menta de las mismas características.
	override method cuantoEspacioOcupa() {return super()*2}
}


