#![no_std]
#![no_main]

mod panic;
mod vga_buffer;

use vga_buffer::{Writer, Color};

// mangle --> changes the name of the function => makes it hashable. No mangle ensures it does not hash 
#[no_mangle]
pub extern "C" fn _start() -> ! {
    use Color::*;
    let mut writer  = Writer::new(Green, Black);
    writer.write("Hello World!");

    loop {}
}

