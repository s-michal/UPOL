package exercise1;

public class Circle implements GetArea, Distance {

    private Point center;
    private double radius;

    public Circle(Point center, double radius) {
        this.center = center;
        this.radius = radius;
    }

    public double getArea() {
        return Math.PI * Math.pow(radius, 2);
    }

    public double distance(Point P) {
        return Math.abs(P.distance(center) - radius);
    }
}
