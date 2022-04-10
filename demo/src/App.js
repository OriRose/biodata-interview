import './App.css'
import Tabs from 'react-bootstrap/Tabs'
import Tab from 'react-bootstrap/Tab'

function App() {
  return (
    <div className="app">
      <h1 style={{textAlign: "center"}}>Put your heart, mind, and soul into even your smallest acts.</h1>
      <h2 style={{textAlign: "right", padding: "5% 0%"}}>This is the secret of success.</h2>
      <div className="container">
        <div className="row">
          <div className="col">
            <blockquote><p>
            Technology is nothing. What's important is that you have a faith in people,
            that they're basically good and smart, and if you give them tools, they'll do
            wonderful things with them.
            </p></blockquote>
          </div>
          <div className="col">
          <blockquote><p>
            Your work is going to fill a large part of your life, and the only way to be truly
            satisfied is to do what you believe is great work. And the only way to do great
            work is to love what you do. If you haven't found it yet, keep looking. Don't
            settle. As with all matters of the heart, you'll know when you find it.
            </p></blockquote>
         </div>
        </div>
      </div>
      <Tabs defaultActiveKey="foolish" id="uncontrolled-tab-example" className="mb-3">
        <Tab eventKey="hungry" title="Stay Hungry">
        Be a yardstick of quality. Some people aren't used to an environment where
        excellence is expected.
        </Tab>
        <Tab eventKey="foolish" title="Stay Foolis">
        Be a yardstick of quantity. All people are used to an environment where
        mediocrity is required.
        </Tab>
        </Tabs>
    </div>
    
  );
}

export default App;
