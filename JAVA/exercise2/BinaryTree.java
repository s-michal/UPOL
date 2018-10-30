package exercise2;

public class BinaryTree<T extends Comparable<T>> {

    private Node<T> newNode;

    class Node<T extends Comparable<T>> {

        T data;
        Node<T> left, right;

        Node(T elem) {
            this.data = elem;
            this.left = null;
            this.right = null;
        }
    }
    
    public boolean search(T element) {
        Node<T> current = newNode;
        while (current != null) {
            int compared = element.compareTo(current.data);
            if (compared < 0)
                current = current.left;
            else if (compared > 0)
                current = current.right;
            else return true;
        }
        return false;
    }

    public boolean add(T element) {
        if (newNode == null) {
            newNode = new Node<T>(element);
            return true;
        }
        Node<T> current = newNode;
        while (true) {
            int compared = element.compareTo(current.data);
            if (compared < 0) {
                if (current.left == null) {
                    current.left = new Node<T>(element);
                    return true;
                }
                current = current.left;
            } else if (compared > 0) {
                if (current.right == null) {
                    current.right = new Node<T>(element);
                    return true;
                }
                current = current.right;
            } else return false;
        }
    }

    //function deleteNode takes the node that is to be deleted
    //and then looks for the leftmost node from right branch to be replaced with
    private Node<T> deleteNode(Node<T> current) {
        if (current.left == null)
            return current.right;
        else if (current.right == null)
            return current.left;
        Node<T> next = current.right;
        if (next.left == null) { //next node is already leftmost
            current.data = next.data;
            current.right = next.right;
            return current;
        }
        Node<T> temp = next.left;
        while (temp != null) { //looking for the leftmost node in the right branch
            next = temp;
            temp = temp.left;
        }
        current.data = next.data;
        next.left = next.right;
        return current;
    }

    public boolean delete(T element) {
        Node<T> current = newNode;
        if (current == null)
            return false;
        else if (current.data == element) {
            newNode = deleteNode(current);
            return true;
        }
        while (true) {
            int compared = element.compareTo(current.data);
            if (compared < 0) {
                if (current.left == null)
                    return false;
                else if (current.left.data == element) {
                    current.left = deleteNode(current.left);
                    return true;
                }
                current = current.left;
            }
            else {
                if (current.right == null)
                    return false;
                else if (current.right.data == element) {
                    current.right = (deleteNode(current.right));
                    return true;
                }
                current = current.right;
            }
        }
    }
}

