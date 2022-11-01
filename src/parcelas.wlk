import plantas.*

class Parcela {
//De cada parcela se conoce:
//su ancho y su largo, medidos en metros. (Para evacuar dudas: sí, van en dos atributos distintos.);
//cuántas horas de sol recibe por día;
//las plantas que tiene, representadas por una colección.
	
	var property ancho
	var property largo
	var property hsDeSol
	const property plantas = #{}
/*Y se pide:

    conocer la superficie de la parcela, que se calcula... multiplicando ancho por largo;
    saber la cantidad máxima de plantas que tolera, que se calcula de la siguiente manera: si el ancho es mayor que el largo, la cuenta es superficie / 5; si no superficie / 3 + largo;
    saber si tiene complicaciones, lo cual es así si alguna de sus plantas tolera menos sol del que recibe la parcela;
    poder plantar una planta que se recibe por parámetro. El efecto que produce es que se agregue a la colección. Esto debe arrojar un error si al plantar se supera la cantidad máxima o bien si la parcela recibe al menos 2 horas más de sol que los que la planta tolera.
 */
 method superficie(){return ancho * largo}
 method cantidadMaximaDePlantasQueTolera(){
 	if (ancho > largo) return (self.superficie() /5)
 	else return (self.superficie() / 3 + largo)
 }
 method tieneComplicaciones (){
 	return plantas.any({p => p.cuantasHsDeSolTolera()< self.hsDeSol()})
 }
 method plantarUnaPlanta (unaPlanta){
 	if (plantas.size() == self.cantidadMaximaDePlantasQueTolera() or self.hsDeSol() > unaPlanta.cuantasHsDeSolTolera() + 2){
		self.error("No se puede plantar")
 		}
 		else {plantas.add(unaPlanta)}
 }
 method ningunaSuperalos1coma5(){return plantas.all({p => p.altura()<1.5})}
 method cantidadDePlantas(){return (plantas.size())}
 method porcentajeDeBuenaAsociacion(){return (plantas.size())}
 
 
 	
}
