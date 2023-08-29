// TCSS 445 Final Project
// Benji Lee and Matthew Burgess
// Sources: https://stackoverflow.com/questions/696782/retrieve-column-names-from-java-sql-resultset
//          https://stackoverflow.com/questions/18981279/the-tcp-ip-connection-to-the-host-localhost-port-1433-has-failed
//          https://learn.microsoft.com/en-us/sql/connect/jdbc/step-3-proof-of-concept-connecting-to-sql-using-java?view=sql-server-ver16
//          https://stackoverflow.com/questions/25803428/how-to-load-a-java-gui-class-from-a-main-class
//          https://stackoverflow.com/questions/3551542/swingutilities-invokelater-why-is-it-needed
//          https://docs.oracle.com/javase/8/docs/api/java/sql/Statement.html

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;

public class QueryUI extends JFrame {

    private JTextField hostTextField;
    private JTextField databaseTextField;
    private JTextField usernameTextField;
    private JPasswordField passwordField;
    private JButton connectButton;
    private JTextArea outputTextArea;
    private JButton queryButton;
    private JButton updateButton;
    private JTextField queryTextField;

    private Connection connection;
    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                new QueryUI();
            }
        });
    }

    public QueryUI() {
        initializeUI();
        initializeListeners();
    }

    private void initializeUI() {
        setTitle("Database UI");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        // Connection panel, where user can edit the host, database, username, and passwords
        JPanel connectionPanel = new JPanel(new GridLayout(5, 2));
        connectionPanel.add(new JLabel("Host:"));
        hostTextField = new JTextField("localhost");
        connectionPanel.add(hostTextField);
        connectionPanel.add(new JLabel("Database:"));
        databaseTextField = new JTextField("Burgess_Lee_Matthew_Benji_db");
        connectionPanel.add(databaseTextField);
        connectionPanel.add(new JLabel("Username:"));
        usernameTextField = new JTextField("sa");
        connectionPanel.add(usernameTextField);
        connectionPanel.add(new JLabel("Password:"));
        passwordField = new JPasswordField();
        connectionPanel.add(passwordField);
        connectionPanel.add(new JLabel());
        connectButton = new JButton("Connect");
        connectionPanel.add(connectButton);
        add(connectionPanel, BorderLayout.NORTH);

        // Output panel, where query output/update results will be printed
        JPanel outputPanel = new JPanel(new BorderLayout());
        outputPanel.add(new JLabel("Statement Output", SwingConstants.CENTER), BorderLayout.NORTH);
        outputTextArea = new JTextArea(20, 50);
        JScrollPane scrollPane = new JScrollPane(outputTextArea);
        outputPanel.add(scrollPane, BorderLayout.CENTER);
        add(outputPanel, BorderLayout.CENTER);

        // Query panel, where the user will type their query or update statements to the database
        JPanel queryPanel = new JPanel(new BorderLayout());
        queryPanel.add(new JLabel("Enter Statement", SwingConstants.CENTER), BorderLayout.NORTH);
        queryTextField = new JTextField();
        queryPanel.add(queryTextField, BorderLayout.CENTER);
        queryButton = new JButton("Query");
        queryPanel.add(queryButton, BorderLayout.WEST);
        updateButton = new JButton("Update");
        queryPanel.add(updateButton, BorderLayout.EAST);
        add(queryPanel, BorderLayout.SOUTH);

        pack();
        setLocationRelativeTo(null);
        setVisible(true);
    }

    // Action event listeners for connect, query, and update buttons
    private void initializeListeners() {
        connectButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                connectToDatabase();
            }
        });

        queryButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                executeQuery();
            }
        });

        updateButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                updateTable();
            }
        });
    }

    // Connecting to SQL database using JDBC (URL formatted for SQL SERVER)
    private void connectToDatabase() {
        String host = hostTextField.getText();
        String database = databaseTextField.getText();
        String username = usernameTextField.getText();
        String password = new String(passwordField.getPassword());

        String url = "jdbc:sqlserver://" + host + ";" + "database=" + database + ";encrypt=true;trustServerCertificate=true;user="
                        + username + ";password=" + password;
        try {
            connection = DriverManager.getConnection(url, username, password);
            outputTextArea.append("Connected to database successfully.\n");
        } catch (SQLException e) {
            outputTextArea.append("Error connecting to database: " + e.getMessage() + "\n");
        }
    }

    // Build output for executed query using ResultSet and executeQuery() method
    private void executeQuery() {
        String query = queryTextField.getText();
        if (connection != null) {
            try {
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(query);
                ResultSetMetaData metaData = resultSet.getMetaData();
                int columnCount = metaData.getColumnCount();

                StringBuilder resultBuilder = new StringBuilder();
                for (int i = 1; i <= columnCount; i++ ) {
                    resultBuilder.append(metaData.getColumnName(i)).append("\t");
                }
                resultBuilder.append("\n");
                while (resultSet.next()) {
                    for (int i = 1; i <= columnCount; i++) {
                        resultBuilder.append(resultSet.getString(i)).append("\t");
                    }
                    resultBuilder.append("\n");
                }

                outputTextArea.append(resultBuilder.toString());
            } catch (SQLException e) {
                outputTextArea.append("Error executing query: " + e.getMessage() + "\n");
            }
        } else {
            outputTextArea.append("Not connected to a database.\n");
        }
    }

    // Build output which reports results of update statement to user
    private void updateTable() {
        String query = queryTextField.getText();
        if (connection != null) {
            try {
                Statement statement = connection.createStatement();
                int rowsAffected = statement.executeUpdate(query);
                outputTextArea.append("Rows affected: " + rowsAffected + "\n");
            } catch (SQLException e) {
                outputTextArea.append("Error updating table: " + e.getMessage() + "\n");
            }
        } else {
            outputTextArea.append("Not connected to a database.\n");
        }
    }
}