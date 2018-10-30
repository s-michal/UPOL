package exercise1;

/*1. Implementovat u třídy Point metodu "... nearest (...[] objects)"
která vrátí objekt, který je bodu nejblíže

2.Implementovat u třídy Point metodu "Object nearest(Object [] objects)
která vrátí objekt, který je bodu nejblíže a objekty u kterých nelze merit vzdalenost bude ignorovat

3. Implementovat metodu "double sumOfAreas(...[] objects) vrací sum ploch objektu, u kterých lze měřit plochu

4.přidat třídu Triangle s metodami  double GetArea() a double distance(Point p), tak abychom nemuseli nic upravovat
*/

public class test {

    /*public static double sumOfAreas(GetArea[] objects) {
        double sum = 0;
        for (GetArea x : objects){
            if (x != null)
                sum += x.getArea();
        }
        return sum;
    }

    public static double distance(Distance[] objects, Point P) {
        double min = objects[0].distance(P);
        for (int i = 1; i < objects.length; i++) {
            double result = objects[i].distance(P);
            if (result < min)
                min = result;
        }
        return min;
    }

    public static void main(String []args) {
        Point X = new Point(2, 2);

        Point A = new Point(2, 2);
        Point B = new Point(5, 2);
        Line AB = new Line(A, B);
        Rectangle one = new Rectangle(A, 2, 3);
        Square two = new Square(B, 5);
        Circle three = new Circle(new Point(2, 2), 2);


        Distance[] arr = new Distance[5];
        arr[0] = one;
        arr[1] = two;
        arr[2] = B;
        arr[3] = AB;
        arr[4] = three;

        //System.out.println(sumOfAreas(arr));
        //System.out.println(distance(arr, X));
        System.out.println(three.distance(X));



    }*/

    public static double sumOfAreas(GetArea[] objects) {
        double sum = 0;
        for (GetArea x : objects){
            if (x != null) {
                sum += x.getArea();
                System.out.println(x.getArea() + "\n");
            }
        }
        return sum;
    }

    public static double distance(Distance[] objects, Point p) {
        double min = Double.MAX_VALUE;
        for (Distance x : objects) {
            double result = x.distance(p);
            if (result < min)
                min = result;
        }
        return min;
    }

    /*public static void main(String []args) {
        Point X = new Point(2, 2);

        Point A = new Point(2, 2);
        Point B = new Point(5, 2);
        Line AB = new Line(A, B);
        Rectangle one = new Rectangle(A, 2, 3);
        Square two = new Square(B, 5);
        Circle three = new Circle(new Point(2, 2), 2);


        Distance[] arr = new Distance[5];
        arr[0] = one;
        arr[1] = two;
        arr[2] = B;
        arr[3] = AB;
        arr[4] = three;

        GetArea[] array = new GetArea[5];
        array[0] = one;
        array[1] = two;
        array[4] = three;

        System.out.println(sumOfAreas(array));
        System.out.println(distance(arr, X));
        System.out.println(three.distance(X));
    }*/

    public static void main (String[] args){

        Point pointA = new Point(2, 1);
        Point pointB = new Point(2, 8);

        System.out.println("Distance: " + pointA.distance(pointB)
                            + ",X of A: " + pointA.getX()
                            + ",Y of A: " + pointA.getY() + "\n");

        Line line = new Line(pointA, pointB);
        System.out.println(line.distance(new Point(2, -5)) + ", "
                            + line.distance(new Point(3, 5)) + ", "
                            + line.distance(new Point(7, 10)) + ", "
                            + pointB.distance(new Point(7, 10)) + "\n");

        Rectangle rectangleA = new Rectangle(pointA, pointB);
        Rectangle rectangleB = new Rectangle(pointA, 7, 3);
        System.out.println(rectangleA.getArea() + ", "
                + rectangleA.distance(new Point(4, 11)) + ", "
                + rectangleA.distance(new Point(3, 6)));
        System.out.println(rectangleB.getArea() + ", "
                + rectangleB.distance(new Point(4, 11)) + ", "
                + rectangleB.distance(new Point(3, 6))+ "\n");

        Square square = new Square(pointA, 7);
        System.out.println(square.getArea() + ", "
                + square.distance(new Point(-5, 15)) + ", "
                + square.distance(new Point(3, 6))+ "\n");

        Circle circle = new Circle(pointA, 3);
        System.out.println(circle.getArea() + ", "
                + circle.distance(new Point(4, 11)) + ", "
                + circle.distance(new Point(3, 3))+ "\n");
    }
}
