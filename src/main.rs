//a to do list
use std::io::{self};
use std::process;
fn main(){
    let mut todolist = TodoList{list: Vec::new()};
    loop {
        program(&mut todolist);
    }

}

fn
program(imported: &mut TodoList) {
    let mut task_input = String::new();
    println!("Operation: 
            1: Add Task
            2: Remove Task
            3: Show all tasks
            4: Exit        
    ");
    io::stdin()
        .read_line(&mut task_input)
        .expect("Error has occured while reading a line.");
    let parsed_task_input:i32 = task_input.trim().parse().expect("Error has occured couldn't read a line.");








    match parsed_task_input {
        1 => add(imported),
        2 => remove_task(imported),
        3 => imported.show_all_taks(),
        _ => process::exit(0),
    }

}

fn add(todolist: &mut TodoList){
    let mut user_input = String::new();
    println!("Write a task: {}", user_input); 
    io::stdin()
        .read_line(&mut user_input)
        .expect("Failed to read a string");
    let parsed_input: String = user_input.trim().parse().expect("Failed to read a string.");
    todolist.add_task(parsed_input);

}
fn remove_task(todolist: &mut TodoList){
    let mut user_index = String::new();
        println!("Enter the task's index:");
        io::stdin()
            .read_line(&mut user_index)
            .expect("Failed to read the tasks position");
    let mut index: i32 = user_index.trim().parse().expect("ERROR");
    index -=1;
    let usize_input = index as usize;
    todolist.remove_task(usize_input);
}

pub struct TodoList {
    list: Vec<String>,
}
impl TodoList {

    
    fn add_task(&mut self, amount_parsed: String) {
        self.list.push(amount_parsed);
        println!("{:?}", self.list)
    }
    
    fn remove_task(&mut self, amount_received: usize) {
        
        if amount_received < self.list.len() {
            self.list.remove(amount_received);
            println!("Task was successfully removed! Left tasks:{:?}", self.list)
        } else {
            println!("Failed to remove task")
        }

    }
    fn show_all_taks(&self) {
        for (i, list) in self.list.iter().enumerate(){
            println!("{}: {}", i+1, list)
        }
    }
}