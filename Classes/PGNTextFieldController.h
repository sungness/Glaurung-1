/*
  Glaurung, a chess program for the Apple iPhone.
  Copyright (C) 2004-2010 Tord Romstad, Marco Costalba, Joona Kiiski.

  Glaurung is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  Glaurung is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#import <UIKit/UIKit.h>

@class GameDetailsTableController;

@interface PGNTextFieldController : UIViewController <UITextFieldDelegate> {
  GameDetailsTableController *gameDetailsController;
  NSString *pgnTag;
  UITextField *textField;
}

- (id)initWithGameDetailsController:(GameDetailsTableController *)gdtc
                             pgnTag:(NSString *)tag;
- (void)editingEnded:(NSNotification *)aNotification;

@end
