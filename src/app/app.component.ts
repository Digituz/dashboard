import { Component, OnInit, OnDestroy } from '@angular/core';
import { Router, NavigationEnd, ActivatedRoute } from '@angular/router';
import { Title } from '@angular/platform-browser';
import { TranslateService } from '@ngx-translate/core';
import { merge } from 'rxjs';
import { filter, map, switchMap } from 'rxjs/operators';

import { environment } from '@env/environment';
import { Logger, untilDestroyed } from '@core';
import { I18nService } from '@app/i18n';
import { SwUpdate } from '@angular/service-worker';
import { MessagesService } from './messages/messages.service';
import { SignInService } from './sign-in/sign-in.service';
import { initDatadog } from './util/logger';

const log = new Logger('App');

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent implements OnInit, OnDestroy {
  loading = false;

  constructor(
    private router: Router,
    private activatedRoute: ActivatedRoute,
    private titleService: Title,
    private translateService: TranslateService,
    private i18nService: I18nService,
    private swUpdate: SwUpdate,
    private messagesService: MessagesService,
    private signInService: SignInService
  ) {}

  ngOnInit() {
    initDatadog();
    // Setup logger
    if (environment.production) {
      Logger.enableProductionMode();
    }

    this.loading = this.signInService.isSignedIn();
    this.signInService.refreshToken().subscribe({
      next: () => {
        this.loading = false;
      },
      error: () => {
        this.signInService.signOut();
        this.loading = false;
        return this.router.navigateByUrl('/');
      },
    });

    this.swUpdate.available.subscribe(() => {
      this.messagesService.showUpdate();
    });

    log.debug('init');

    // Setup translations
    this.i18nService.init(environment.defaultLanguage, environment.supportedLanguages);

    const onNavigationEnd = this.router.events.pipe(filter((event) => event instanceof NavigationEnd));

    // Change page title on navigation or language change, based on route data
    merge(this.translateService.onLangChange, onNavigationEnd)
      .pipe(
        map(() => {
          let route = this.activatedRoute;
          while (route.firstChild) {
            route = route.firstChild;
          }
          return route;
        }),
        filter((route) => route.outlet === 'primary'),
        switchMap((route) => route.data),
        untilDestroyed(this)
      )
      .subscribe((event) => {
        const title = event.title;
        if (title) {
          this.titleService.setTitle(this.translateService.instant(title));
        }
      });
  }

  ngOnDestroy() {
    this.i18nService.destroy();
  }
}
