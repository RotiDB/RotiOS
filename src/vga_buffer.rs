// Allow unused components to exist in the memory 
#![allow(unused)]

#[derive(Debug, Clone, PartialEq, Eq)]
// Map enum integers to unsigned 8 bit integer
#[repr(u8)]

pub enum Color {
    Black      = 0x0,
    Blue       = 0x1,
    Green      = 0x2,
    Cyan       = 0x3,
    Red        = 0x4,
    Magenta    = 0x5,
    Brown      = 0x6,
    LightGray  = 0x7,
    DarkGray   = 0x8,
    LightBlue  = 0x9,
    LightGreen = 0xa,
    LightCyan  = 0xb,
    LightRed   = 0xc,
    Pink       = 0xd,
    Yellow     = 0xe,
    White      = 0xf,
}

#[repr(C)]
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct ColorCode(u8);

impl ColorCode {
    fn new(foreground: Color, background: Color) -> Self {
        Self((background  as u8) << 4 | foreground as u8) // 02
    }
}

#[repr(C)]
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct Screen {
    ascii_char: u8,
    color: ColorCode
}

const BUFFER_HEIGHT: usize = 25;
const BUFFER_WIDTH: usize = 80;

#[repr(transparent)]
struct Buffer {
    chars: [[Screen; BUFFER_WIDTH]; BUFFER_HEIGHT]
}

pub struct Writer {
    column: usize,
    color_code: ColorCode,
    buffer: &'static mut Buffer
}


impl Writer {
    pub fn new(foreground: Color, background: Color) -> Self {
        Self {
            column: 0,
            color_code: ColorCode::new(foreground, background),
            buffer: unsafe { &mut *(0xb8000 as *mut Buffer)}
        }
    }

    pub fn write(&mut self, s: &str) {
        for byte in s.bytes() {
            match &byte {
                0x20..= 0x70 | b'\n' => self.write_byte(byte),
                _ => self.write_byte(0xfe),
            }
        }
    }

    fn write_byte(&mut self, byte: u8) {
        match byte {
            b'\n' => {
                self.newline();
            }
            other => {
                if self.column >= BUFFER_WIDTH {
                    self.newline();
                }
                
                self.buffer.chars[BUFFER_HEIGHT - 1][BUFFER_WIDTH] = Screen {
                    ascii_char: other,
                    color: self.color_code
                };

                self.column += 1;
            } 
        }
    }
    
    fn newline(&mut self) {
        todo!();
    }
}