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

#import "Options.h"
#import "OptionsViewController.h"
#import "StrengthOptionController.h"


@implementation StrengthOptionController

- (id)initWithParentViewController:(OptionsViewController *)ovc {
  if (self = [super init]) {
    parentController = ovc;
  }
  return self;
}


- (void)loadView {
  [super loadView];

  UIView *contentView;
  CGRect r = [[UIScreen mainScreen] applicationFrame];

  [self setTitle: @"Strength"];

  contentView = [[UIView alloc] initWithFrame: r];
  [contentView setBackgroundColor: [UIColor whiteColor]];
  [self setView: contentView];

  UIPickerView *picker = [[UIPickerView alloc]
                           initWithFrame: CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
  [picker setDelegate: self];
  [picker setDataSource: self];
  [picker setShowsSelectionIndicator: YES];
  [picker selectRow: 66 - (([[Options sharedOptions] strength] - 800) / 25)
        inComponent: 0
           animated: NO];
  [contentView addSubview: picker];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
  return 67;
}


- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
  return [NSString stringWithFormat: @"%ld", 800 + (66 - row) * 25];
}


- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
  [[Options sharedOptions] setStrength: 800 + ( 66 - ( int )row ) * 25];
  [parentController updateTableCells];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
  // Release anything that's not essential, such as cached data
}




@end
