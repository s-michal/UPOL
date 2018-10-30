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

namespace csharp_2
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


        private void button_Click_1(object sender, RoutedEventArgs e)
        {
            int a = int.Parse(stranaA.Text);
            int b = int.Parse(stranaB.Text);
            int c = int.Parse(stranaC.Text);

            if (a + b > c)
            {
                if (a + c > b)
                {
                    if (b + c > a)
                        result.Content = "Trojúhelník lze sestrojit.";
                        obvod.Content = (a + b + c).ToString();
                }
                    
            }
            else
                result.Content = "Trojúhelník nelze sestrojit";

        }

    }
}
