# README
###Basthor Marketplace

##Instrucciones de inicializacion 
- para inicializar el proyecto lo primero que hay que hacer es clonar el repositorio.

- una vez clonado y almacenado en nuestra maquina procedemos a ubicar el archivo paypal.yml, en el se  se definen las credenciales para hacer uso de este servicio, usted debera proporcionar sus credenciales propias para conseguirlas dar  [click aqui!](https://developer.paypal.com/) y seguir la documentacion. 

- ahora volviendo a la terminal corremos el comando rails 

>rails db:create

>rails db:migrate

>rails db:seed


- este ultimo comando poblara la base de datos anterior mente creada y junto con ello podremos hacer uso de el usuario con rol provider que se crea en el. 

email = usuariotienda@gmail.com
password = 123456

con el podremos crear una tienda para ello debemos ir a la barra de navegacion y en el icono de mercado dar click sobre el

rellenamos los campos del formulario, especificamos las imagenes que queremos usar y ya tendremos nuestro perfil tienda donde podremos publicar nuestros productos. 

- ya configurado paypal  y sus credenciales ademas de haber ejecutado los comandos previos en esta guia  abrimos una terminal y utilizamos el comando rails s, nos dirigimos a un navegador y en la barra de busqueda escribimos lo siguiente 

>localhost:3000

ya tenemos la aplicacion corriendo.
utilizamos las credenciales proporcionadas anteriormente y nos logeamos como proveedor. 
creamos un comercio mediante el formulario.
y en el creamos un producto, rellenando el formulario.

- en el seed habran un par de lineas comentadas, una vez ejecutados los pasos anteriores procedemos a comentar todas las lineas del seed y a descomentar las que previamente lo estaban, para asi poder generar ordenes para la tienda que anteriormente creamos.

- los datos de las ordenes para las tiendas se pueden apreciar en la barra de navegacion "Dashboard"

ejecutamos 
>rails db:seed 

- con esto ya tendremos datos que respectan a las ordenes de la tienda y junto con ello se formaran los graficos.


- Para utilizar la aplicacion con el rol de cliente debemos utilizar las siguientes credenciales.

email: usuariocliente@gmail.com
password: 123456.
