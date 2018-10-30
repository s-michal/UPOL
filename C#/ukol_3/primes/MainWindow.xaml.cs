using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace primes
{
    /// <summary>
    /// Interakční logika pro MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();

        }

        private Boolean isPrime(int number)
        {

            if (number <= 1)
                return false;
          
            for (int i = 2; i <= Math.Sqrt(number); i++)
            {
                if ((number % i) == 0)
                    return false;
            }
            return true;
        }

        private void vypisButton_Click(object sender, RoutedEventArgs e)
        {
            output.Text = "";
          
            try {
                int number = int.Parse(num.Text);
                if (number <= 2)
                    throw new Exception("No primes smaller than 2");

                for (int i = 0; i < number; i++)
                {
                    if (isPrime(i))
                        output.Text += i.ToString() + ", ";

                }
            }

            catch(FormatException ex)
            {
                output.Text = "";
                error.Content = "Input should be of type number";

            }

            catch (OverflowException ex)
            {
                output.Text = "";
                error.Content = "Input is too big";

            }

            catch (Exception ex)
            {
                output.Text = "";
                error.Content = ex.Message;
            }
            






            }
        }
}
