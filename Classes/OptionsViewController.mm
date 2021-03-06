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

#import "AboutController.h"
#import "BoardViewController.h"
#import "EditUserNameController.h"
#import "Options.h"
#import "OptionsViewController.h"
#import "RemoteEngineTableController.h"
#import "SimpleOptionTableController.h"
#import "StrengthOptionController.h"
//#import "TextChoiceCell.h"


@implementation OptionsViewController

@synthesize boardViewController;

- (id)initWithBoardViewController:(BoardViewController *)bvc {
  if (self = [super initWithStyle: UITableViewStyleGrouped]) {
    [self setTitle: @"Options"];
    boardViewController = bvc;
  }
  return self;
}


- (void)loadView {
  [super loadView];
  [[self navigationItem] setRightBarButtonItem:
                           [[UIBarButtonItem alloc]
                              initWithTitle: @"Done"
                                      style: UIBarButtonItemStylePlain
                                     target: boardViewController
                                     action: @selector(optionsMenuDonePressed)]];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
  // Release anything that's not essential, such as cached data
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 5;
}


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  switch(section) {
  case 0: return 3;
  case 1: return 5;
  case 2: return 4;
  case 3: return 1;
  case 4: return 1;
  }
  return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger row = [indexPath row];
  NSInteger section = [indexPath section];

#if 0
  TextChoiceCell *cell =
    (TextChoiceCell *)[tableView dequeueReusableCellWithIdentifier:
                                   nil/*@"any-cell"*/];
  if (cell == nil)
    cell = [[[TextChoiceCell alloc] initWithFrame: CGRectZero
                                  reuseIdentifier: nil/*@"any-cell"*/
                                   nameLabelWidth: 160.0f]
             autorelease];
#endif
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: nil];
  if (cell == nil)
    cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1
                                   reuseIdentifier: nil];

  if (section == 0) {
    UISwitch *sw;
    if (row == 0) {
      [[cell textLabel] setText: @"Show analysis"];
      sw = [[UISwitch alloc] initWithFrame: CGRectMake(4.0f, 16.0f, 10.0f, 28.0f)];
      [sw setOn: [[Options sharedOptions] showAnalysis] animated: NO];
      [sw addTarget: self action: @selector(toggleShowAnalysis:)
          forControlEvents:UIControlEventValueChanged];
      [cell setAccessoryView: sw];
    }
    else if (row == 1) {
      [[cell textLabel] setText: @"Show book moves"];
      sw = [[UISwitch alloc] initWithFrame: CGRectMake(4.0f, 16.0f, 10.0f, 28.0f)];
      [sw setOn: [[Options sharedOptions] showBookMoves] animated: NO];
      [sw addTarget: self action: @selector(toggleShowBookMoves:)
          forControlEvents:UIControlEventValueChanged];
      [cell setAccessoryView: sw];
    }
    else if (row == 2) {
      [[cell textLabel] setText: @"Show legal moves"];
      sw = [[UISwitch alloc] initWithFrame: CGRectMake(4.0f, 16.0f, 10.0f, 28.0f)];
      [sw setOn: [[Options sharedOptions] showLegalMoves] animated: NO];
      [sw addTarget: self action: @selector(toggleShowLegalMoves:)
          forControlEvents:UIControlEventValueChanged];
      [cell setAccessoryView: sw];
    }
  }
  else if (section == 1) {
    if (row == 0) {
      UISwitch *sw;
      [[cell textLabel] setText: @"Permanent brain"];
      sw = [[UISwitch alloc] initWithFrame: CGRectMake(4.0f, 16.0f, 10.0f, 28.0f)];
      [sw setOn: [[Options sharedOptions] permanentBrain] animated: NO];
      [sw addTarget: self action: @selector(togglePermanentBrain:)
          forControlEvents:UIControlEventValueChanged];
      [sw setEnabled: YES];
      [cell setAccessoryView: sw];
    }
    else {
      if (row == 1) {
        [[cell textLabel] setText: @"Play style"];
        [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
        [[cell detailTextLabel] setText: [[Options sharedOptions] playStyle]];
        //[cell setValueText: [[Options sharedOptions] playStyle]];
      }
      else if (row == 2) {
        [[cell textLabel] setText: @"Book variety"];
        [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
        [[cell detailTextLabel] setText: [[Options sharedOptions] bookVariety]];
        //[cell setValueText: [[Options sharedOptions] bookVariety]];
      }
      else if (row == 3) {
        [[cell textLabel] setText: @"Strength"];
        [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
        [[cell detailTextLabel]
          setText: [NSString stringWithFormat: @"%d",
                             [[Options sharedOptions] strength]]];
        /*
          [cell setValueText: [NSString stringWithFormat: @"%d",
          [[Options sharedOptions] strength]]];
        */
      }
      else if (row == 4) {
        [[cell textLabel] setText: @"Remote engine"];
        [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
        if ([boardViewController isConnectedToServer])
          [[cell detailTextLabel] setText: [[Options sharedOptions] serverName]];
        else
          [[cell detailTextLabel] setText: @"Not connected"];
      }
    }
  }
  else if (section == 2) {
    if (row == 0) {
      [[cell textLabel] setText: @"Piece set"];
      [[cell detailTextLabel] setText: [[Options sharedOptions] pieceSet]];
      //[cell setValueText: [[Options sharedOptions] pieceSet]];
      [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    }
    else if (row == 1) {
      [[cell textLabel] setText: @"Color scheme"];
      [[cell detailTextLabel] setText: [[Options sharedOptions] colorScheme]];
      //[cell setValueText: [[Options sharedOptions] colorScheme]];
      [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    }
    else if (row == 2) {
      [[cell textLabel] setText: @"Sounds"];
      [[cell detailTextLabel] setText: [[Options sharedOptions] soundVolume]];
      //[cell setValueText: [[Options sharedOptions] soundVolume]];
      [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    }
    else if (row == 3) {
      [[cell textLabel] setText: @"Figurine notation"];
      UISwitch *sw;
      sw = [[UISwitch alloc] initWithFrame: CGRectMake(4.0f, 16.0f, 10.0f, 28.0f)];
      [sw setOn: [[Options sharedOptions] figurineNotation] animated: NO];
      [sw addTarget: self action: @selector(toggleFigurines:)
          forControlEvents:UIControlEventValueChanged];
      [cell setAccessoryView: sw];
    }
  }
  else if (section == 3) {
    if (row == 0) {
      [[cell textLabel] setText: @"Your name"];
      [[cell detailTextLabel] setText: [[Options sharedOptions] fullUserName]];
      //[cell setValueText: [[Options sharedOptions] fullUserName]];
      [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    }
  }
  else if (section == 4) {
    if (row == 0) {
      [[cell textLabel] setText: @"About/Help"];
      [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    }
  }
  else {
    [[cell textLabel] setText: [NSString stringWithFormat: @"section %ld, row %ld",
                                         (long)section, (long)row]];
  }
  return cell;
}


- (void)deselect {
  [[self tableView] deselectRowAtIndexPath:
                      [[self tableView] indexPathForSelectedRow]
                                  animated: YES];
}


- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath:
  (NSIndexPath *)newIndexPath {
  int row = ( int )newIndexPath.row;
  int section = ( int )newIndexPath.section;
  NSLog(@"section %d, row %d", section, row);

  [self performSelector: @selector(deselect:) withObject: tableView
             afterDelay: 0.1f];

  SimpleOptionTableController *sotc;
  if (section == 1) {
    if (row == 1) {
      // Play style
      sotc = [[SimpleOptionTableController alloc]
               initWithOption: @"Play style"
               parentViewController: self];
      [[self navigationController] pushViewController: sotc
                                             animated: YES];
    }
    else if (row == 2) {
      // Book variety
      sotc = [[SimpleOptionTableController alloc]
               initWithOption: @"Book variety"
               parentViewController: self];
      [[self navigationController] pushViewController: sotc
                                             animated: YES];
    }
    else if (row == 3) {
      // Strength
      StrengthOptionController *soc;
      soc = [[StrengthOptionController alloc]
              initWithParentViewController: self];
      [[self navigationController] pushViewController: soc
                                             animated: YES];
    }
    else if (row == 4) {
      // Remote engine
      RemoteEngineTableController *retc;
      retc = [[RemoteEngineTableController alloc]
               initWithParentViewController: self];
      [[self navigationController] pushViewController: retc
                                             animated: YES];
    }
  }
  else if (section == 2) {
    if (row == 0) {
      // Piece set
      sotc = [[SimpleOptionTableController alloc]
               initWithOption: @"Piece set"
               parentViewController: self];
      [[self navigationController] pushViewController: sotc
                                             animated: YES];
    }
    else if (row == 1) {
      // Color scheme
      sotc = [[SimpleOptionTableController alloc]
               initWithOption: @"Color scheme"
               parentViewController: self];
      [[self navigationController] pushViewController: sotc
                                             animated: YES];
    }
    else if (row == 2) {
      // Sounds
      sotc = [[SimpleOptionTableController alloc]
               initWithOption: @"Sounds"
               parentViewController: self];
      [[self navigationController] pushViewController: sotc
                                             animated: YES];
    }
  }
  else if (section == 3) {
    if (row == 0) {
      // User name
      EditUserNameController *eunc = [[EditUserNameController alloc]
                                       initWithParentViewController: self];
      [[self navigationController] pushViewController: eunc animated: YES];
    }
  }
  else if (section == 4) {
    if (row == 0) {
      AboutController *ac = [[AboutController alloc] init];
      [[self navigationController] pushViewController: ac animated: YES];
    }
  }
}


- (void)deselect:(UITableView *)tableView {
  [tableView deselectRowAtIndexPath: [tableView indexPathForSelectedRow]
                           animated: YES];
}


- (void)toggleShowAnalysis:(id)sender {
  [[Options sharedOptions] setShowAnalysis: [sender isOn]];
  if (![sender isOn])
    [boardViewController hideAnalysis];
}

- (void)toggleShowBookMoves:(id)sender {
  [[Options sharedOptions] setShowBookMoves: [sender isOn]];
  if ([sender isOn])
    [boardViewController showBookMoves];
  else
    [boardViewController hideBookMoves];
}

- (void)toggleShowLegalMoves:(id)sender {
  [[Options sharedOptions] setShowLegalMoves: [sender isOn]];
}

- (void)togglePermanentBrain:(id)sender {
  [[Options sharedOptions] setPermanentBrain: [sender isOn]];
}

- (void)toggleFigurines:(id)sender {
  [[Options sharedOptions] setFigurineNotation: [sender isOn]];
}

- (void)updateTableCells {
  [[self tableView] reloadData];
}



@end
