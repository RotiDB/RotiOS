use core::arch::global_asm;

#[allow(dead_code)]
#[derive(Debug, Clone, PartialEq, Eq)]
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

#[repr(transparent)]
#[derive(Debug, Clone, PartialEq, Eq)]
struct ColorCode(u8);

impl ColorCode {
    fn new(foreground: Color, background: Color) -> Self {
        Self(background as u8)
    }
}

struct Screen {
    ascii_char: u8,
    color: ColorCode
}

const BUFFER_HEIGHT: u8 = 25;
const BUFFER_WIDTH: u8 = 80;

