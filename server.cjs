const express = require('express');
const bodyParser = require('body-parser');
const { exec } = require('child_process');

const app = express();
const PORT = 3000;

app.use(bodyParser.urlencoded({ extended: true }));

app.get('/', (req, res) => {
    res.send(`
        <form action="/start" method="POST">
            <label for="gamePin">Game Pin:</label>
            <input type="text" id="gamePin" name="gamePin" required><br><br>
            <label for="botName">Bot Name:</label>
            <input type="text" id="botName" name="botName" required><br><br>
            <label for="botAmount">Bot Amount:</label>
            <input type="number" id="botAmount" name="botAmount" required><br><br>
            <input type="submit" value="Start Flooding">
        </form>
    `);
});

app.post('/start', (req, res) => {
    const { gamePin, botName, botAmount } = req.body;

    // Construct the command to run the Blooket Flooder
    const command = `node /BlookFlood/index.js ${gamePin} ${botName} ${botAmount}`;

    // Execute the command
    exec(command, (error, stdout, stderr) => {
        if (error) {
            console.error(`Error: ${error.message}`);
            return res.status(500).send('Error occurred while starting the flooder.');
        }
        if (stderr) {
            console.error(`stderr: ${stderr}`);
            return res.status(500).send('Error occurred while starting the flooder.');
        }
        console.log(`stdout: ${stdout}`);
        res.send('Flooder started successfully!');
    });
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
