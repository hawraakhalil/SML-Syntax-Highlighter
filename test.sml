(* Functions needed from HW1 and modified for pattern matching *)
fun rgb2gray rgb =
    case rgb of
        (r, g, b) => (r*3 + g*6 + b) div 10
fun isBrighter(rgb1, rgb2) =
    if rgb2gray(rgb1) > rgb2gray(rgb2) then true
    else false
fun brightest(image) = 
    let
        fun brightesthelper(image, max) = 
            case image of 
                    [] => max
                  | pixel::image' => if isBrighter(pixel, max)
                                    then brightesthelper(image', pixel)
                                    else brightesthelper(image', max)
    in
        brightesthelper(image, (0 , 0 , 0))
    end

(* Part 1 *)
fun countWhite images =
    let fun aux(images , acc) = 
        case images of 
            [] => acc
          | image::images' => if rgb2gray(brightest(image)) = 255
                              then aux(images' , acc+1)
                              else aux(images', acc)
    in 
        aux(images, 0)
    end

(* Part 2 *)
datatype Node = Leaf of int 
              | NonLeaf of int * Node * Node 
val myTree = NonLeaf(2 , Leaf(1), NonLeaf(4, Leaf(3), Leaf(5)))
fun nodeValue n =
    case n of 
        Leaf a => a
      | NonLeaf(a , b ,c) => a
fun treeSize n =
    case n of 
        Leaf a => 1
      | NonLeaf(a, b ,c) => 1 + treeSize(b) + treeSize(c)
fun numLeaves n =
    case n of 
        Leaf a => 1
      | NonLeaf(a, b, c) => numLeaves(b) + numLeaves(c)
fun numGreaterThan (n, num) =
    case n of 
        Leaf a => if a > num then 1 else 0
      | NonLeaf(a,b,c) => if a > num 
                          then 1 + numGreaterThan(b, num) + numGreaterThan(c, num)
                          else numGreaterThan(b, num) + numGreaterThan(c, num)
fun traverseTree (n, f, g) = 
    case n of 
        Leaf a => f(a)
      | NonLeaf(a,b,c) => g(a,traverseTree(b,f,g),traverseTree(c,f,g))
fun traverse(n) = 
    traverseTree(n, (fn a => Int.toString a) , (fn (a,b,c) =>Int.toString a ^ " " ^ b ^ " " ^ c ))
fun treeSize2(n) =
    traverseTree(n, (fn a => 1) , (fn (a,b,c) => 1 + b + c))
fun numGreaterThan2(n, num) = 
    traverseTree( n, (fn a =>  if a > num then 1 else 0 ) , (fn (a,b,c) => if a > num then 1+b+c else b+c))

(* Tests *)
val result1 = countWhite([[(255, 255, 255) , (150, 190, 250)],[(255, 255, 255) , (100, 150, 200)],[(120, 170, 220) , (150, 190, 250)]]) (* expected output: 2 *)
val result2 = nodeValue(NonLeaf(4 , Leaf(2) , Leaf(3))) (* expected output: 4 *)
val result3 = treeSize(NonLeaf(2 , NonLeaf(1, Leaf(3), Leaf(5)), Leaf(4))) (* expected output: 5 *)
val result4 = numLeaves(NonLeaf(2 , NonLeaf(1, Leaf(3), Leaf(5)), Leaf(4))) (* expected output: 3 *)
val result5 = numGreaterThan((NonLeaf(2 , NonLeaf(1, Leaf(3), Leaf(5)), Leaf(4))) , 2) (* expected output: 3 *)
val result6 = traverse(NonLeaf(2 , NonLeaf(1, Leaf(3), Leaf(5)), Leaf(4))) (* expected output: "2 1 3 5 4" *)
val result7 = treeSize2(NonLeaf(2 , NonLeaf(1, Leaf(3), Leaf(5)), Leaf(4))) (* expected output: 5 *)
val result8 = numGreaterThan2((NonLeaf(2 , NonLeaf(1, Leaf(3), Leaf(5)), Leaf(4))) , 2) (* expected output: 3 *)
