#![no_std]
#![no_main]

mod panic;
mod vga_buffer;

use vga_buffer::{Writer, Color};

#[no_mangle]
pub extern "C" fn _start() -> ! {
    use Color::*;
    let mut writer  = Writer::new(Green, Black);
    writer.write("Hello World!");
    
    loop {}
}