import React, { lazy, Suspense, useState, useEffect } from "react";
import ReactDOM from "react-dom";
import TaskList from './components/TaskList';

import "./index.css";

const App = () => {
  const [jwt, setJwt] = useState('');

  return   <>
    <div className="container">
      <div>Name: tasks</div>
      <div>Framework: react</div>
      <div>Language: JavaScript</div>
      <div>CSS: Empty CSS</div>
    </div>

    <Suspense fallback={<div>Loading...</div>}>
      <TaskList jwt={jwt} />
    </Suspense>
  </>
};
ReactDOM.render(<App />, document.getElementById("app"));
