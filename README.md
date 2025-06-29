# ProyectoArquiC35035

Debido a complicaciones con el display map, decidí cambiar el tablero de sudoku de un 9x9 a un 4x4. Esto debido a que el display map, al intentar generar uno de 512x512 px no cargaba la mitad inferior, no pude descubrir el porqué sucedía esto, asi que decidí dejarlo como un 4x4 ya que este si cabe en el display map de 256x256.

De igual manera, en la propuesta original implementé dos dificultades, fácil y media, en este caso decidí solo implementar la fácil, ya que también tuve dificultad para generar un menú apropiado para las dificultades en el display map. Si hubiera sido posible implementar más de una dificultad, sin embargo, aún me falta práctica con el display map.

SET UP DEL DISPLAY MAP:
  -Unit Width in Pixels: 8
  -Unit Height in Pixels: 8
  -Display Width in Pixels: 256
  -Display Width in Pixels: 256
  -Base address: 0x10008000 ($gp)

