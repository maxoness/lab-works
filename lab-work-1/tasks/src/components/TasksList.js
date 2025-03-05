import React, { useEffect, useState } from 'react';
import api from '../utils/api';
import './TasksList.css';

export default function TasksList({ jwt }) {
    const [tasks, setTasks] = useState([]);

    useEffect(() => {
        console.log('before setting tasks')
        if (tasks) {
            console.log('setting tasks')
            setTasks(api.getTasks(jwt));
        }
    }, [jwt]);

    function checkChanged(id, prevChecked) {
        const updatedTasks = tasks.map((x) => {
            api.checkedChanged(jwt, id, !prevChecked);
            return x.id === id
                ? {
                    id: x.id,
                    title: x.title,
                    description: x.description,
                    checked: !prevChecked,
                }
                : x;
        });
        setTasks(updatedTasks);
    }

    return (
        <div className='tasks-list'>
            <h3>Задачи на сегодня</h3>
            {
                tasks.map((x) => {
                    return (
                        <div key={x.id}>
                            <div>
                                <input type='checkbox' onChange={() => checkChanged(x.id, x.checked)} checked={x.checked} />
                                <span className={x.checked ? 'completed' : ''}>{x.title}</span>
                            </div>
                        </div>
                    );
                })}
        </div>
    );
}
